import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

class HomeHeader extends StatelessWidget {
  final User user;
  final VoidCallback? onProfileTap;
  final VoidCallback? onCreditsTap;
  final VoidCallback? onNotificationsTap;

  const HomeHeader({
    super.key,
    required this.user,
    this.onProfileTap,
    this.onCreditsTap,
    this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info do usuário + badge de créditos
          _UserInfoRow(
            user: user,
            onProfileTap: onProfileTap,
            onCreditsTap: onCreditsTap,
          ),
          AppSpacing.verticalMD,
          _TitleRow(onNotificationsTap: onNotificationsTap),
        ],
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  final User user;
  final VoidCallback? onProfileTap;
  final VoidCallback? onCreditsTap;

  const _UserInfoRow({
    required this.user,
    this.onProfileTap,
    this.onCreditsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _UserProfile(user: user, onTap: onProfileTap),
        ),
        AppSpacing.horizontalSM,
        CreditBadge(credits: user.credits, onTap: onCreditsTap),
      ],
    );
  }
}

class _UserProfile extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;

  const _UserProfile({required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _UserAvatar(avatarUrl: user.avatarUrl),
          AppSpacing.horizontalSM,
          AppSpacing.horizontalXS,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo,',
                  style: AppTextStyles.bodySmall(context),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _getFirstName(user.name),
                  style: AppTextStyles.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getFirstName(String fullName) {
    final parts = fullName.trim().split(' ');
    return parts.isNotEmpty ? parts[0] : fullName;
  }
}

class _UserAvatar extends StatelessWidget {
  final String? avatarUrl;

  const _UserAvatar({this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.avatarMedium,
      height: AppDimensions.avatarMedium,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: AppDimensions.opacityLow),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(
            alpha: AppDimensions.opacityMedium,
          ),
          width: AppDimensions.borderThick,
        ),
      ),
      child: avatarUrl != null
          ? ClipOval(
              child: Image.network(
                avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _defaultAvatar(),
              ),
            )
          : _defaultAvatar(),
    );
  }

  Widget _defaultAvatar() {
    return const Icon(
      Icons.person,
      color: AppColors.primary,
      size: AppDimensions.iconMD,
    );
  }
}

class _TitleRow extends StatelessWidget {
  final VoidCallback? onNotificationsTap;

  const _TitleRow({this.onNotificationsTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Nossa Estante', style: AppTextStyles.h2(context)),
        IconButton(
          onPressed: onNotificationsTap,
          icon: Icon(Icons.notifications_outlined, color: context.textColor),
          tooltip: 'Notificações',
        ),
      ],
    );
  }
}
