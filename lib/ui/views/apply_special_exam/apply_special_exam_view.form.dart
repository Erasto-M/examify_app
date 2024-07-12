// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String ReasonValueKey = 'reason';

final Map<String, TextEditingController>
    _ApplySpecialExamViewTextEditingControllers = {};

final Map<String, FocusNode> _ApplySpecialExamViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ApplySpecialExamViewTextValidations = {
  ReasonValueKey: null,
};

mixin $ApplySpecialExamView {
  TextEditingController get reasonController =>
      _getFormTextEditingController(ReasonValueKey);

  FocusNode get reasonFocusNode => _getFormFocusNode(ReasonValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ApplySpecialExamViewTextEditingControllers.containsKey(key)) {
      return _ApplySpecialExamViewTextEditingControllers[key]!;
    }

    _ApplySpecialExamViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ApplySpecialExamViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ApplySpecialExamViewFocusNodes.containsKey(key)) {
      return _ApplySpecialExamViewFocusNodes[key]!;
    }
    _ApplySpecialExamViewFocusNodes[key] = FocusNode();
    return _ApplySpecialExamViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    reasonController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    reasonController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ReasonValueKey: reasonController.text,
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

    for (var controller in _ApplySpecialExamViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ApplySpecialExamViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ApplySpecialExamViewTextEditingControllers.clear();
    _ApplySpecialExamViewFocusNodes.clear();
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

  String? get reasonValue => this.formValueMap[ReasonValueKey] as String?;

  set reasonValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ReasonValueKey: value}),
    );

    if (_ApplySpecialExamViewTextEditingControllers.containsKey(
        ReasonValueKey)) {
      _ApplySpecialExamViewTextEditingControllers[ReasonValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasReason =>
      this.formValueMap.containsKey(ReasonValueKey) &&
      (reasonValue?.isNotEmpty ?? false);

  bool get hasReasonValidationMessage =>
      this.fieldsValidationMessages[ReasonValueKey]?.isNotEmpty ?? false;

  String? get reasonValidationMessage =>
      this.fieldsValidationMessages[ReasonValueKey];
}

extension Methods on FormStateHelper {
  setReasonValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ReasonValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    reasonValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ReasonValueKey: getValidationMessage(ReasonValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _ApplySpecialExamViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ApplySpecialExamViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      ReasonValueKey: getValidationMessage(ReasonValueKey),
    });
