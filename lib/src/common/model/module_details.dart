part of '../common.dart';

/// 详细信息
final class ModuleDetails {
  const ModuleDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
  });

  /// 模块通道,模块的唯一标识符
  final String id;

  /// 模块标题
  final String title;

  /// 模块描述
  final String description;

  /// 模块类型
  final ModuleType type;

  /// 使用Map解析模块详细信息
  factory ModuleDetails.formData({
    required ModuleData data,
    required ModuleType type,
  }) {
    return ModuleDetails(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      type: type,
    );
  }
}
