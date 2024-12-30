import 'package:flutter/material.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
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
    switch (platformType) {
      case PlatformType.slack:
        controllers['token'] = TextEditingController(text: widget.metadata?.botToken);
        controllers['clientId'] = TextEditingController(text: widget.metadata?.clientId);
        controllers['clientSecret'] = TextEditingController(text: widget.metadata?.clientSecret);
        controllers['signingSecret'] = TextEditingController(text: widget.metadata?.signingSecret);
        break;
      case PlatformType.telegram:
        controllers['token'] = TextEditingController(text: widget.metadata?.botToken);
        break;
      case PlatformType.messenger:
        controllers['token'] = TextEditingController(text: widget.metadata?.botToken);
        controllers['botPageId'] = TextEditingController(text: widget.metadata?.botPageId);
        controllers['botAppSecret'] = TextEditingController(text: widget.metadata?.botAppSecret);
        break;
    }
  }

  Widget _buildConfigurationFields(Platform platform) {
    switch (platformType) {
      case PlatformType.slack:
        return Column(
          children: [
            _buildStepConfigurationSlack(platform),
            _buildTextField('Bot Token', controllers['token']!),
            _buildTextField('Client ID', controllers['clientId']!),
            _buildTextField('Client Secret', controllers['clientSecret']!),
            _buildTextField('Signing Secret', controllers['signingSecret']!),
          ],
        );
      case PlatformType.telegram:
        return Column(
          children: [
            _buildStepConfigurationTelegram(platform),
            _buildTextField('Bot Token', controllers['token']!),
          ],
        );
      case PlatformType.messenger:
        return Column(
          children: [
            _buildStepConfigurationMessenger(platform),
            _buildTextField('Bot Token', controllers['token']!),
            _buildTextField('Bot Page ID', controllers['botPageId']!),
            _buildTextField('Bot App Secret', controllers['botAppSecret']!),
          ],
        );
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

  Widget _buildStepConfigurationSlack(Platform platform) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Text(
            'Step 1: ${widget.platform.name} copylink',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),
          Text(
            'Copy the following content to your ${widget.platform.name} app configuration page.',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'OAuth2 Redirect URLs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${Constant.baseKnowledgeUrl}/kb-core/v1/bot-integration/slack/auth/${platform.assistantId}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Event Request URL',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${Constant.baseKnowledgeUrl}/kb-core/v1/hook/slack/${platform.assistantId}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Slash Request URL',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${Constant.baseKnowledgeUrl}/kb-core/v1/hook/slack/slash/${platform.assistantId}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Step 2: ${widget.platform.name} information',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );
  }

  Widget _buildStepConfigurationTelegram(Platform platform) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            'Step 1: ${widget.platform.name} information',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );
  }

  Widget _buildStepConfigurationMessenger(Platform platform) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            'Step 1: ${widget.platform.name} copylink',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Copy the following content to your ${widget.platform.name} app configuration page.',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Callback URL',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${Constant.baseKnowledgeUrl}/kb-core/v1/hook/messenger/${platform.assistantId}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Verify Token',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'knowledge',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Step 2: ${widget.platform.name} information',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /* Text(
              'Configure your ${widget.platform.name} bot',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24), */
            /* Text(
              'Connect to ${widget.platform.name} Bots and chat with this bot in ${widget.platform.name} App',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _launchHelpUrl,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'How to obtain ${widget.platform} configurations?',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                const SizedBox(width: 4),
                const Icon(Icons.open_in_new, size: 16, color: Colors.blue),
                ],
              ),
            ), */
            // const SizedBox(height: 12),
            const SizedBox(height: 12),
            _buildConfigurationFields(widget.platform),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(),
    );
  }

  Widget _buildActionButtons() {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                // TODO: Add save configuration logic
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}