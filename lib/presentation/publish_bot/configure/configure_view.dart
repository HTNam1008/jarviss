import 'package:flutter/material.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/publish_bot/configure/configure_viewmodel.dart';
import 'package:jarvis/presentation/publish_bot/publish_bot_viewmodel.dart';
// import 'package:url_launcher/url_launcher.dart';

class ConfigureView extends StatefulWidget {
  final Platform platform;
  final dynamic metadata;

  const ConfigureView({
    super.key,
    required this.platform,
    this.metadata,
  });

  @override
  State<ConfigureView> createState() => _ConfigureViewState();
}

class _ConfigureViewState extends State<ConfigureView> {
  late final ConfigureViewModel _viewModel;
  final Map<String, TextEditingController> controllers = {};
  late final PlatformType platformType;

/*   final Map<String, String> _helpUrls = {
    'slack': 'https://www.jarvis.cx/help/knowledge-base/publish-bot/slack',
    'telegram': 'https://www.jarvis.cx/help/knowledge-base/publish-bot/telegram',
    'messenger': 'https://www.jarvis.cx/help/knowledge-base/publish-bot/messenger',
  }; */

/* Future<void> _launchHelpUrl() async {
  try {
    final url = _helpUrls[widget.platform.name.toLowerCase()];
    if (url != null) {
      final uri = Uri.parse(url);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not launch URL'),
            ),
          );
        }
      }
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error launching URL: $e'),
        ),
      );
    }
  }
} */

  @override
  void initState() {
    super.initState();
    platformType = _getPlatformType(widget.platform.name);
    _initControllers();

    _viewModel = getIt<ConfigureViewModel>();
    _viewModel.init(widget.platform);

    // Listen for errors
    _viewModel.outputError.listen((error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  PlatformType _getPlatformType(String platform) {
    switch (platform.toLowerCase()) {
      case 'slack':
        return PlatformType.slack;
      case 'telegram':
        return PlatformType.telegram;
      case 'messenger':
        return PlatformType.messenger;
      default:
        throw Exception('Unknown platform type');
    }
  }

  void _initControllers() {
    final config = ConfigurationFields.platformConfigs[platformType];

    for (final field in config?.fields ?? []) {
      String? initialValue;
      switch (field) {
        case ConfigField.botToken:
          initialValue = widget.metadata?.botToken;
          break;
        case ConfigField.clientId:
          initialValue = widget.metadata?.clientId;
          break;
        case ConfigField.clientSecret:
          initialValue = widget.metadata?.clientSecret;
          break;
        case ConfigField.signingSecret:
          initialValue = widget.metadata?.signingSecret;
          break;
        case ConfigField.pageId:
          initialValue = widget.metadata?.pageId;
          break;
        case ConfigField.appSecret:
          initialValue = widget.metadata?.appSecret;
          break;
      }
      controllers[field.label] = TextEditingController(text: initialValue);
    }
  }

  Widget _buildConfigurationFields() {
    return Column(
      children: [
        _buildStepConfiguration(),
        ...ConfigurationFields.platformConfigs[platformType]?.fields.map((field) => _buildTextField(field.label, controllers[field.label]!)) ?? [],
      ],
    );
  }

  Widget _buildStepConfiguration() {
    switch (platformType) {
      case PlatformType.slack:
        return _buildStepConfigurationSlack();
      case PlatformType.telegram:
        return _buildStepConfigurationTelegram();
      case PlatformType.messenger:
        return _buildStepConfigurationMessenger();
    }
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildStepConfigurationSlack() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Text(_viewModel.getStepTitle(1)),
          const SizedBox(height: 8),
          Text('Copy the following content to your ${widget.platform.name} app configuration page.'),
          const SizedBox(height: 16),
          _buildUrlSection('OAuth2 Redirect URLs', _viewModel.getEventUrl('slack_oauth')),
          _buildUrlSection('Event Request URL', _viewModel.getEventUrl('slack_event')),
          _buildUrlSection('Slash Request URL', _viewModel.getEventUrl('slack_slash')),
          Text(_viewModel.getStepTitle(2)),
        ],
      ),
    );
  }

  Widget _buildUrlSection(
    String title,
    String url,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          url,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStepConfigurationTelegram() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Text(_viewModel.getStepTitle(1)),
            Text(_viewModel.getStepTitle(2)),
          ],
        ));
  }

  Widget _buildStepConfigurationMessenger() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Text(_viewModel.getStepTitle(1)),
          const SizedBox(height: 8),
          Text('Copy the following content to your ${widget.platform.name} app configuration page.'),
          const SizedBox(height: 16),
          _buildUrlSection('Callback URL', _viewModel.getEventUrl('messenger_callback')),
          _buildUrlSection('Verify Token', 'knowledge'),
          Text(_viewModel.getStepTitle(2)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeaderBar(
        centerWidget: Text(
          'Configure ${widget.platform.name} Bot',
          style: const TextStyle(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildConfigurationFields(),
      ),
      bottomNavigationBar: _buildActionButtons(widget.platform),
    );
  }

  Widget _buildActionButtons(Platform platform) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 16),
            platform.isVerified
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: _handleDisconnect,
                    child: const Text('Disconnect'),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: _handleVerify,
                    child: const Text('Save'),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleVerify() async {
    final values = controllers.map((key, controller) => MapEntry(key, controller.text));
    final success = await _viewModel.verifyBot(values);
    if (success && mounted) {
      Navigator.pop(context, values);
    }
  }  

  Future<void> _handleDisconnect() async {
    final success = await _viewModel.disconnectBot();
    if (success && mounted) {
      Navigator.pop(context);
    }
  }
}
