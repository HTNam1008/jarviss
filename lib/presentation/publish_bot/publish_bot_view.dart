import 'package:flutter/material.dart';
import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/common/loading_overlay.dart';
import 'package:jarvis/presentation/resources/assets_manager.dart';
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
      backgroundColor: Colors.teal.shade50,
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
        child: const Text('Publish Bot',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  void _onPublishPressed() async {
    final success = await _viewModel.publishBot();
    // TODO: show dialog success or error and show redirect url
    if (success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Publish Success!',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Redirect:'),
                SizedBox(height: 8),
                Text('- Slack: https://slack.com'),
                SizedBox(height: 4),
                Text('- Telegram: https://telegram.org'),
                SizedBox(height: 4),
                Text('- Messenger: https://messenger.com'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Publish Failed!',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            content: const Text('An error occurred while publishing the bot.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
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
        CircleAvatar(
          backgroundImage: AssetImage(ImageAssets.getPlatformIcon(platform.name)),
          backgroundColor: Colors.transparent,
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
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Configure',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}