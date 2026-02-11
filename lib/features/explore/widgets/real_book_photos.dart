import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Widget que exibe as fotos reais do livro adicionadas pelo dono
class RealBookPhotos extends StatelessWidget {
  final List<String> photoUrls;

  const RealBookPhotos({super.key, required this.photoUrls});

  @override
  Widget build(BuildContext context) {
    if (photoUrls.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Real Book Photos',
          style: AppTextStyles.h5(
            context,
          ).copyWith(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: photoUrls.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _PhotoThumbnail(
                photoUrl: photoUrls[index],
                index: index,
                totalPhotos: photoUrls.length,
                allPhotos: photoUrls,
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Miniatura de foto com tap para visualização completa
class _PhotoThumbnail extends StatelessWidget {
  final String photoUrl;
  final int index;
  final int totalPhotos;
  final List<String> allPhotos;

  const _PhotoThumbnail({
    required this.photoUrl,
    required this.index,
    required this.totalPhotos,
    required this.allPhotos,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPhotoViewer(context);
      },
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.isDark
              ? const Color(0xFF1F2937) // gray-800
              : const Color(0xFFE5E7EB), // gray-200
          border: Border.all(
            color: context.borderColor.withValues(
              alpha: AppDimensions.opacityMedium,
            ),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Foto
              Image.network(
                photoUrl,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: context.textMuted,
                    size: 40,
                  ),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                    ),
                  );
                },
              ),

              // Contador de foto
              if (totalPhotos > 1)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(
                        alpha: AppDimensions.opacityMediumHigh,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${index + 1}/$totalPhotos',
                      style: AppTextStyles.caption(context).copyWith(
                        color: AppColors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhotoViewer(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            _PhotoViewerPage(photos: allPhotos, initialIndex: index),
      ),
    );
  }
}

/// Página de visualização de fotos em tela cheia
class _PhotoViewerPage extends StatefulWidget {
  final List<String> photos;
  final int initialIndex;

  const _PhotoViewerPage({required this.photos, required this.initialIndex});

  @override
  State<_PhotoViewerPage> createState() => _PhotoViewerPageState();
}

class _PhotoViewerPageState extends State<_PhotoViewerPage> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black.withValues(
          alpha: AppDimensions.opacityMediumHigh,
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${_currentIndex + 1} / ${widget.photos.length}',
          style: AppTextStyles.bodyLarge(
            context,
          ).copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.photos.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Center(
              child: Image.network(
                widget.photos[index],
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.white,
                        size: 80,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Não foi possível carregar a imagem',
                        style: AppTextStyles.bodyLarge(
                          context,
                        ).copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
