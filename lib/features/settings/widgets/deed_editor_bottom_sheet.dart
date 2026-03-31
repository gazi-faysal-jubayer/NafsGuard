import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/models/deed.dart';
import '../../../core/models/deed_category.dart';
import '../../../shared/widgets/primary_button.dart';

class DeedEditorBottomSheet extends StatefulWidget {
  final ValueChanged<Deed> onSave;

  const DeedEditorBottomSheet({super.key, required this.onSave});

  @override
  State<DeedEditorBottomSheet> createState() => _DeedEditorBottomSheetState();
}

class _DeedEditorBottomSheetState extends State<DeedEditorBottomSheet> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  DeedCategory _selectedCategory = DeedCategory.tongue;

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final duration = int.tryParse(_durationController.text.trim());

    final deed = Deed(
      id: const Uuid().v4(),
      title: title,
      category: _selectedCategory,
      durationSeconds: duration,
      isCustom: true,
    );

    widget.onSave(deed);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: NafsColors.primaryDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: NafsColors.accentGold,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: NafsColors.ashMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Add Custom Deed', style: NafsTextStyles.headlineMedium),
          const SizedBox(height: 20),
          TextField(
            controller: _titleController,
            style: NafsTextStyles.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Deed Title',
              labelStyle: NafsTextStyles.labelMedium,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: NafsColors.accentGold.withValues(alpha: 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: NafsColors.accentGold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<DeedCategory>(
            initialValue: _selectedCategory,
            dropdownColor: NafsColors.cardSurface,
            style: NafsTextStyles.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Category',
              labelStyle: NafsTextStyles.labelMedium,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: NafsColors.accentGold.withValues(alpha: 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: NafsColors.accentGold),
              ),
            ),
            items: DeedCategory.values.map((cat) {
              return DropdownMenuItem(
                value: cat,
                child: Text(cat.displayName),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedCategory = val);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _durationController,
            style: NafsTextStyles.bodyMedium,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Duration (seconds) — optional',
              labelStyle: NafsTextStyles.labelMedium,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: NafsColors.accentGold.withValues(alpha: 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: NafsColors.accentGold),
              ),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Save Deed',
            onPressed: _save,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
