import "package:jarvis/app/constant.dart";

String getModelId(String modelConstant) {
    switch (modelConstant) {
        case ConstantAssistantID.CLAUDE_3_HAIKU_20240307:
            return 'claude-3-haiku-20240307';
        case ConstantAssistantID.CLAUDE_3_SONNET_20240229:
            return 'claude-3-sonnet-20240229';
        case ConstantAssistantID.GEMINI_15_FLASH_LATEST:
            return 'gemini-1.5-flash-latest';
        case ConstantAssistantID.GEMINI_15_PRO_LATEST:
            return 'gemini-1.5-pro-latest';
        case ConstantAssistantID.GPT_4_O:
            return 'gpt-4o';
        case ConstantAssistantID.GPT_4_O_MINI:
            return 'gpt-4o-mini';
        default:
            return 'unknown_model';
    }
}

String getModelName(String modelConstant) {
    switch (modelConstant) {
        case ConstantAssistantID.CLAUDE_3_HAIKU_20240307:
            return 'Claude 3 Haiku';
        case ConstantAssistantID.CLAUDE_3_SONNET_20240229:
            return 'Claude 3 Sonnet';
        case ConstantAssistantID.GEMINI_15_FLASH_LATEST:
            return 'Gemini 1.5 Flash';
        case ConstantAssistantID.GEMINI_15_PRO_LATEST:
            return 'Gemini 1.5 Pro';
        case ConstantAssistantID.GPT_4_O:
            return 'GPT-4o';
        case ConstantAssistantID.GPT_4_O_MINI:
            return 'GPT-4o mini';
        default:
            return 'Unknown Model';
    }
}