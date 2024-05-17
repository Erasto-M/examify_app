// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String ForgotPasswordEmailValueKey = 'forgotPasswordEmail';

final Map<String, TextEditingController>
    _ForgotPasswordViewTextEditingControllers = {};

final Map<String, FocusNode> _ForgotPasswordViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ForgotPasswordViewTextValidations = {
  ForgotPasswordEmailValueKey: null,
};

mixin $ForgotPasswordView {
  TextEditingController get forgotPasswordEmailController =>
      _getFormTextEditingController(ForgotPasswordEmailValueKey);

  FocusNode get forgotPasswordEmailFocusNode =>
      _getFormFocusNode(ForgotPasswordEmailValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ForgotPasswordViewTextEditingControllers.containsKey(key)) {
      return _ForgotPasswordViewTextEditingControllers[key]!;
    }

    _ForgotPasswordViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ForgotPasswordViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ForgotPasswordViewFocusNodes.containsKey(key)) {
      return _ForgotPasswordViewFocusNodes[key]!;
    }
    _ForgotPasswordViewFocusNodes[key] = FocusNode();
    return _ForgotPasswordViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    forgotPasswordEmailController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    forgotPasswordEmailController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ForgotPasswordEmailValueKey: forgotPasswordEmailController.text,
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

    for (var controller in _ForgotPasswordViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ForgotPasswordViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ForgotPasswordViewTextEditingControllers.clear();
    _ForgotPasswordViewFocusNodes.clear();
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

  String? get forgotPasswordEmailValue =>
      this.formValueMap[ForgotPasswordEmailValueKey] as String?;

  set forgotPasswordEmailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ForgotPasswordEmailValueKey: value}),
    );

    if (_ForgotPasswordViewTextEditingControllers.containsKey(
        ForgotPasswordEmailValueKey)) {
      _ForgotPasswordViewTextEditingControllers[ForgotPasswordEmailValueKey]
          ?.text = value ?? '';
    }
  }

  bool get hasForgotPasswordEmail =>
      this.formValueMap.containsKey(ForgotPasswordEmailValueKey) &&
      (forgotPasswordEmailValue?.isNotEmpty ?? false);

  bool get hasForgotPasswordEmailValidationMessage =>
      this.fieldsValidationMessages[ForgotPasswordEmailValueKey]?.isNotEmpty ??
      false;

  String? get forgotPasswordEmailValidationMessage =>
      this.fieldsValidationMessages[ForgotPasswordEmailValueKey];
}

extension Methods on FormStateHelper {
  setForgotPasswordEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ForgotPasswordEmailValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    forgotPasswordEmailValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ForgotPasswordEmailValueKey:
          getValidationMessage(ForgotPasswordEmailValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _ForgotPasswordViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ForgotPasswordViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      ForgotPasswordEmailValueKey:
          getValidationMessage(ForgotPasswordEmailValueKey),
    });
