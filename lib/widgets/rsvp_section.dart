import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ebram_martina_wedding/utils/localizations.dart';
import '../theme/app_theme.dart';

enum AttendingStatus { yes, no }

class RsvpSection extends StatefulWidget {
  const RsvpSection({
    super.key,
    required this.deviceType,
    required this.loc,
  });

  final DeviceType deviceType;
  final AppLocalizations loc;

  @override
  State<RsvpSection> createState() => _RsvpSectionState();
}

class _RsvpSectionState extends State<RsvpSection>
    with SingleTickerProviderStateMixin {
  // ============================================================
  // GOOGLE APPS SCRIPT
  // ============================================================

  static const String _scriptUrl =
      'https://script.google.com/macros/s/AKfycbyzkBSsj8OFG1guq-2m5E-vx6J874zyS66V23sjXscoVXntwovYIzfxPraYzxZWn0W2Uw/exec';

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController =
  TextEditingController();

  // ============================================================
  // STATE
  // ============================================================

  AttendingStatus? _attending;

  bool _submitted = false;
  bool _loading = false;
  String? _errorMessage;

  // ============================================================
  // ANIMATION
  // ============================================================

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // ============================================================
  // VALIDATION
  // ============================================================

  bool get _canSubmit =>
      _nameController.text.trim().isNotEmpty;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_onNameChanged);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  void _onNameChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);

    _nameController.dispose();
    _messageController.dispose();

    _animationController.dispose();

    super.dispose();
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  Future<void> _submit() async {
    if (!_canSubmit || _loading) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final uri = Uri.parse(_scriptUrl).replace(
        queryParameters: {
          'name': _nameController.text.trim(),
          'attending': _attending == null
              ? ''
              : (_attending == AttendingStatus.yes
              ? 'yes'
              : 'no'),
          'message': _messageController.text.trim(),
        },
      );

      await http.get(uri);

      if (!mounted) return;

      setState(() {
        _submitted = true;
      });

      _animationController
        ..reset()
        ..forward();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = 'حصل خطأ، حاول تاني';
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final bool isDesktop =
        widget.deviceType == DeviceType.desktop;

    return Container(
      width: double.infinity,
      color: AppColors.paper,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 30 : 18,
        vertical: isDesktop ? 75 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 540,
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _submitted
                  ? _buildThanks(isDesktop)
                  : _buildForm(isDesktop),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FORM
  // ============================================================

  Widget _buildForm(bool isDesktop) {
    final double titleSize = isDesktop ? 46 : 38;

    return Column(
      children: [

        // Title line 1
        Text(
          widget.loc.guestMessageTitleLine1,
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(
            fontSize: titleSize,
            height: 1,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: AppColors.terracotta,
          ),
        ),

        // Title line 2
        Text(
          widget.loc.guestMessageTitleLine2,
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(
            fontSize: titleSize,
            height: 1,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: AppColors.terracotta,
          ),
        ),

        const SizedBox(height: 28),

        _buildRsvpCard(isDesktop),
      ],
    );
  }

  // ============================================================
  // RSVP CARD
  // ============================================================

  Widget _buildRsvpCard(bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 36 : 22,
        isDesktop ? 30 : 24,
        isDesktop ? 36 : 22,
        isDesktop ? 30 : 24,
      ),
      decoration: BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.gold.withOpacity(.55),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withOpacity(.035),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // ======================================================
          // ATTENDING QUESTION
          // ======================================================

          Text(
            widget.loc.guestAttendingQuestion,
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: isDesktop ? 22 : 20,
              fontWeight: FontWeight.w500,
              color: AppColors.ink,
              letterSpacing: .2,
            ),
          ),

          const SizedBox(height: 16),

          // ======================================================
          // YES / NO
          // ======================================================

          _buildAttendanceButtons(),

          const SizedBox(height: 25),

          // ======================================================
          // DIVIDER
          // ======================================================

          _buildGoldLine(),

          const SizedBox(height: 24),

          // ======================================================
          // NAME FIELD
          // ======================================================

          _buildNameField(),

          const SizedBox(height: 16),

          // ======================================================
          // MESSAGE FIELD
          // ======================================================

          _buildMessageField(),

          const SizedBox(height: 20),

          // ======================================================
          // SUBMIT BUTTON
          // ======================================================

          _buildSubmitButton(),

          // ======================================================
          // ERROR
          // ======================================================

          if (_errorMessage != null) ...[
            const SizedBox(height: 10),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: GoogleFonts.jost(
                fontSize: 12,
                color: AppColors.terracotta,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // ATTENDANCE BUTTONS
  // ============================================================

  Widget _buildAttendanceButtons() {
    return Row(
      children: [
        Expanded(
          child: _AttendingButton(
            label: widget.loc.guestAttendingYes,
            selected:
            _attending == AttendingStatus.yes,
            onTap: () {
              setState(() {
                _attending = AttendingStatus.yes;
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _AttendingButton(
            label: widget.loc.guestAttendingNo,
            selected:
            _attending == AttendingStatus.no,
            onTap: () {
              setState(() {
                _attending = AttendingStatus.no;
              });
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // NAME FIELD
  // ============================================================

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      style: GoogleFonts.jost(
        fontSize: 15,
        color: AppColors.ink,
      ),
      cursorColor: AppColors.olive,
      decoration: InputDecoration(
        isDense: true,

        // Keep the same hint
        hintText:
        "${widget.loc.guestMessageNameHint} *",

        hintStyle: GoogleFonts.jost(
          fontSize: 14,
          color: AppColors.inkSoft.withOpacity(.55),
        ),

        // Same structure as the original field
        filled: true,
        fillColor: AppColors.cream.withOpacity(.35),

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color:
            AppColors.gold.withOpacity(.45),
            width: 1.1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.olive,
            width: 1.4,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE FIELD
  // ============================================================

  Widget _buildMessageField() {
    return SizedBox(
      height: 180,
      child: TextField(
        controller: _messageController,

        // Keep original behavior
        expands: true,
        maxLines: null,
        textAlignVertical:
        TextAlignVertical.top,

        style: GoogleFonts.jost(
          fontSize: 14,
          color: AppColors.ink,
        ),

        cursorColor: AppColors.olive,

        decoration: InputDecoration(
          // Keep original hint
          hintText:
          widget.loc.guestMessageHint,

          hintStyle: GoogleFonts.jost(
            fontSize: 14,
            color:
            AppColors.inkSoft.withOpacity(.5),
          ),

          // Keep original padding
          contentPadding:
          const EdgeInsets.all(18),

          filled: true,
          fillColor:
          AppColors.cream.withOpacity(.35),

          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: BorderSide(
              color:
              AppColors.gold.withOpacity(.45),
              width: 1.1,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.olive,
              width: 1.4,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SUBMIT BUTTON
  // ============================================================

  Widget _buildSubmitButton() {
    final bool enabled =
        _canSubmit && !_loading;

    return AnimatedContainer(
      duration:
      const Duration(milliseconds: 220),
      width: double.infinity,
      height: 46,

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(50),

        color: enabled
            ? AppColors.olive
            : AppColors.sageLight
            .withOpacity(.65),

        boxShadow: enabled
            ? [
          BoxShadow(
            color: AppColors.olive
                .withOpacity(.14),
            blurRadius: 12,
            offset:
            const Offset(0, 5),
          ),
        ]
            : null,
      ),

      child: ElevatedButton(
        onPressed:
        enabled ? _submit : null,

        style:
        ElevatedButton.styleFrom(
          backgroundColor:
          Colors.transparent,
          disabledBackgroundColor:
          Colors.transparent,
          shadowColor:
          Colors.transparent,
          elevation: 0,

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(50),
          ),
        ),

        child: _loading
            ? const SizedBox(
          width: 18,
          height: 18,
          child:
          CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 1.8,
          ),
        )
            : Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              widget.loc
                  .guestMessageSendButton,
              style:
              GoogleFonts.jost(
                fontSize: 14,
                fontWeight:
                FontWeight.w500,
                letterSpacing: .3,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons
                  .favorite_border_rounded,
              size: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // THANK YOU
  // ============================================================

  Widget _buildThanks(bool isDesktop) {
    return Column(
      children: [
        const Icon(
          Icons.favorite_rounded,
          size: 12,
          color: AppColors.rosee,
        ),

        const SizedBox(height: 12),

        Text(
          widget.loc
              .guestMessageThankYouTitle,
          textAlign: TextAlign.center,
          style:
          GoogleFonts.cormorantGaramond(
            fontSize:
            isDesktop ? 46 : 38,
            fontStyle:
            FontStyle.italic,
            fontWeight:
            FontWeight.w500,
            color:
            AppColors.terracotta,
          ),
        ),

        const SizedBox(height: 12),

        _buildDivider(),

        const SizedBox(height: 30),

        // ======================================================
        // PHOTO
        // ======================================================

        TweenAnimationBuilder<double>(
          tween: Tween(
            begin: .88,
            end: 1,
          ),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
          builder: (_, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Container(
            width: isDesktop ? 230 : 190,
            height: isDesktop ? 230 : 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.gold.withOpacity(.65),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.ink.withOpacity(.06),
                  blurRadius: 20,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/image_message.jpeg',
                fit: BoxFit.cover,
                alignment: const Alignment(0, 0.15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),

        // ======================================================
        // THANK YOU BODY
        // ======================================================

        Text(
          widget.loc
              .guestMessageThankYouBody(
            _nameController.text,
          ),
          textAlign: TextAlign.center,
          style: GoogleFonts.jost(
            fontSize: 14,
            height: 1.75,
            color: AppColors.inkSoft,
          ),
        ),

        const SizedBox(height: 13),

        Text(
          widget.loc
              .guestMessageThankYouFooter,
          textAlign: TextAlign.center,
          style:
          GoogleFonts.cormorantGaramond(
            fontSize: 24,
            fontStyle:
            FontStyle.italic,
            color:
            AppColors.olive,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SMALL DIVIDER
  // ============================================================

  Widget _buildDivider() {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Container(
          width: 52,
          height: .8,
          color:
          AppColors.gold
              .withOpacity(.55),
        ),

        const SizedBox(width: 9),

        const Icon(
          Icons.favorite_rounded,
          size: 7,
          color: AppColors.gold,
        ),

        const SizedBox(width: 9),

        Container(
          width: 52,
          height: .8,
          color:
          AppColors.gold
              .withOpacity(.55),
        ),
      ],
    );
  }

  // ============================================================
  // CARD DIVIDER
  // ============================================================

  Widget _buildGoldLine() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: .7,
            color:
            AppColors.gold
                .withOpacity(.28),
          ),
        ),

        const SizedBox(width: 10),

        const Icon(
          Icons.favorite_rounded,
          size: 7,
          color: AppColors.rosee,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Container(
            height: .7,
            color:
            AppColors.gold
                .withOpacity(.28),
          ),
        ),
      ],
    );
  }
}

// =================================================================
// ATTENDING BUTTON
// =================================================================

class _AttendingButton
    extends StatelessWidget {
  const _AttendingButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 220),

        height: 44,

        decoration: BoxDecoration(
          color: selected
              ? AppColors.sageLight
              .withOpacity(.7)
              : AppColors.paper,

          borderRadius:
          BorderRadius.circular(50),

          border: Border.all(
            color: selected
                ? AppColors.olive
                : AppColors.gold
                .withOpacity(.5),

            width:
            selected ? 1.25 : 1,
          ),
        ),

        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              selected
                  ? Icons.favorite_rounded
                  : Icons
                  .favorite_border_rounded,

              size: 14,

              color: selected
                  ? AppColors.rosee
                  : AppColors.olive,
            ),

            const SizedBox(width: 7),

            Flexible(
              child: Text(
                label,

                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,

                textAlign:
                TextAlign.center,

                style:
                GoogleFonts.jost(
                  fontSize: 13,

                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w500,

                  color:
                  AppColors.ink,

                  letterSpacing: .1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}