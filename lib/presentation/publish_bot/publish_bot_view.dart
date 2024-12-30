import 'package:flutter/material.dart';
import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/common/loading_overlay.dart';
import 'publish_bot_viewmodel.dart';

class PublishBotView extends StatefulWidget {
  final String assistantId;

  const PublishBotView({super.key, required this.assistantId});

  @override
  State<PublishBotView> createState() => _PublishBotViewState();
}

class _PublishBotViewState extends State<PublishBotView> {
  late final PublishBotViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<PublishBotViewModel>();
    _viewModel.init(widget.assistantId);
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeaderBar(
        centerWidget: const Text(
          'Publish Bot',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<bool>(
        stream: _viewModel.outputIsLoading,
        builder: (context, loadingSnapshot) {
          return LoadingOverlay(
            isLoading: loadingSnapshot.data ?? false,
            child: _buildContent(),
          );
        },
      ),
      bottomNavigationBar: _buildPublishButton(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select platforms where you want to publish your bot. Each platform requires configuration before publishing.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: StreamBuilder<List<Platform>>(
              stream: _viewModel.outputPlatforms,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final platform = snapshot.data![index];
                    return PlatformListItem(
                      platform: platform,
                      onConfigureTap: () => _viewModel.navigateToConfigureView(context, platform),
                      onCheckChanged: (value) => 
                          _viewModel.togglePlatform(platform, value ?? false),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublishButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: _onPublishPressed,
        child: const Text('Publish Bot'),
      ),
    );
  }

  void _onPublishPressed() async {
    final success = await _viewModel.publishBot();
    if (success && mounted) {
      Navigator.pop(context, true);
    }
  }
}


class PlatformListItem extends StatelessWidget {
  final Platform platform;
  final VoidCallback onConfigureTap;
  final Function(bool?) onCheckChanged;

  const PlatformListItem({
    super.key,
    required this.platform,
    required this.onConfigureTap,
    required this.onCheckChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: platform.isSelected,
          onChanged: onCheckChanged,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                platform.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                platform.isVerified ? 'Verified' : 'Not Configured',
                style: TextStyle(
                  color: platform.isVerified ? Colors.green : Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onConfigureTap,
          child: const Text('Configure'),
        ),
      ],
    );
  }
}