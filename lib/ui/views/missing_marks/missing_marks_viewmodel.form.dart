// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SemesterStageValueKey = 'semesterStage';

final Map<String, TextEditingController>
    _MissingMarksViewModelTextEditingControllers = {};

final Map<String, FocusNode> _MissingMarksViewModelFocusNodes = {};

final Map<String, String? Function(String?)?>
    _MissingMarksViewModelTextValidations = {
  SemesterStageValueKey: null,
};

mixin $MissingMarksViewModel {
  TextEditingController get semesterStageController =>
      _getFormTextEditingController(SemesterStageValueKey);

  FocusNode get semesterStageFocusNode =>
      _getFormFocusNode(SemesterStageValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_MissingMarksViewModelTextEditingControllers.containsKey(key)) {
      return _MissingMarksViewModelTextEditingControllers[key]!;
    }

    _MissingMarksViewModelTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _MissingMarksViewModelTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_MissingMarksViewModelFocusNodes.containsKey(key)) {
      return _MissingMarksViewModelFocusNodes[key]!;
    }
    _MissingMarksViewModelFocusNodes[key] = FocusNode();
    return _MissingMarksViewModelFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    semesterStageController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    semesterStageController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SemesterStageValueKey: semesterStageController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _MissingMarksViewModelTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _MissingMarksViewModelFocusNodes.values) {
      focusNode.dispose();
    }

    _MissingMarksViewModelTextEditingControllers.clear();
    _MissingMarksViewModelFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get semesterStageValue =>
      this.formValueMap[SemesterStageValueKey] as String?;

  set semesterStageValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SemesterStageValueKey: value}),
    );

    if (_MissingMarksViewModelTextEditingControllers.containsKey(
        SemesterStageValueKey)) {
      _MissingMarksViewModelTextEditingControllers[SemesterStageValueKey]
          ?.text = value ?? '';
    }
  }

  bool get hasSemesterStage =>
      this.formValueMap.containsKey(SemesterStageValueKey) &&
      (semesterStageValue?.isNotEmpty ?? false);

  bool get hasSemesterStageValidationMessage =>
      this.fieldsValidationMessages[SemesterStageValueKey]?.isNotEmpty ?? false;

  String? get semesterStageValidationMessage =>
      this.fieldsValidationMessages[SemesterStageValueKey];
}

extension Methods on FormStateHelper {
  setSemesterStageValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SemesterStageValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    semesterStageValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SemesterStageValueKey: getValidationMessage(SemesterStageValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _MissingMarksViewModelTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _MissingMarksViewModelTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SemesterStageValueKey: getValidationMessage(SemesterStageValueKey),
    });
