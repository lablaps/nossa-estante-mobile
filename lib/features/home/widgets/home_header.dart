import 'package:flutter/material.dart';
import '../../../core/domain/entities/entities.dart';
import '../../../core/mocks/mocks.dart';
import '../../../core/theme/theme.dart';

/// Header da página principal do app
///
/// Exibe informações do usuário (avatar, nome, créditos)
/// e título "Nossa Estante" com botão de notificações.
class HomeHeader extends StatelessWidget {
  /// Callback chamado ao tocar no perfil do usuário
  final VoidCallback? onProfileTap;

  /// Callback chamado ao tocar nos créditos
  final VoidCallback? onCreditsTap;

  /// Callback chamado ao tocar nas notificações
  final VoidCallback? onNotificationsTap;

  const HomeHeader({
    super.key,
    this.onProfileTap,
    this.onCreditsTap,
    this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    // Obtém dados do usuário atual
    final currentUser = MockUsers.currentUser;

    return Container(
      padding: AppSpacing.paddingPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linha superior: Info do usuário + Badge de créditos
          _UserInfoRow(
            user: currentUser,
            onProfileTap: onProfileTap,
            onCreditsTap: onCreditsTap,
          ),
          AppSpacing.verticalMD,

          // Linha inferior: Título + Notificações
          _TitleRow(onNotificationsTap: onNotificationsTap),
        ],
      ),
    );
  }
}

/// Linha com informações do usuário e badge de créditos
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
        // Avatar + Nome do usuário
        Expanded(
          child: _UserProfile(user: user, onTap: onProfileTap),
        ),
        AppSpacing.horizontalSM,
        // Badge de créditos
        _CreditsBadge(credits: user.credits, onTap: onCreditsTap),
      ],
    );
  }
}

/// Avatar e nome do usuário
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
          // Avatar do usuário
          _UserAvatar(avatarUrl: user.avatarUrl),
          AppSpacing.horizontalSM,
          AppSpacing.horizontalXS,
          // Nome e saudação
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

  /// Extrai o primeiro nome do usuário
  String _getFirstName(String fullName) {
    final parts = fullName.trim().split(' ');
    return parts.isNotEmpty ? parts[0] : fullName;
  }
}

/// Avatar circular do usuário
class _UserAvatar extends StatelessWidget {
  final String? avatarUrl;

  const _UserAvatar({this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.avatarMedium,
      height: AppDimensions.avatarMedium,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(AppDimensions.opacityMediumLow),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withOpacity(AppDimensions.opacityMedium),
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

/// Badge exibindo quantidade de créditos
class _CreditsBadge extends StatelessWidget {
  final int credits;
  final VoidCallback? onTap;

  const _CreditsBadge({required this.credits, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.paddingBadge,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(
            context.isDark
                ? AppDimensions.opacityMediumLow
                : AppDimensions.opacityLow,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withOpacity(AppDimensions.opacityMedium),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.token,
              color: context.isDark ? AppColors.primary : AppColors.primaryDark,
              size: 18,
            ),
            AppSpacing.horizontalXS,
            Text(
              '$credits ${_pluralize(credits)}',
              style: AppTextStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.bold,
                color: context.isDark
                    ? AppColors.primary
                    : AppColors.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _pluralize(int count) {
    return count == 1 ? 'Crédito' : 'Créditos';
  }
}

/// Linha com título e botão de notificações
class _TitleRow extends StatelessWidget {
  final VoidCallback? onNotificationsTap;

  const _TitleRow({this.onNotificationsTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Título principal
        Text('Nossa Estante', style: AppTextStyles.h2(context)),
        // Botão de notificações
        IconButton(
          onPressed: onNotificationsTap,
          icon: Icon(Icons.notifications_outlined, color: context.textColor),
          tooltip: 'Notificações',
        ),
      ],
    );
  }
}
