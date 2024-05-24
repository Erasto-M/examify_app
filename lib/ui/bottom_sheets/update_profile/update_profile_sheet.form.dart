// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String UpdateUserNameValueKey = 'updateUserName';
const String UpdateEmailValueKey = 'updateEmail';
const String UpdatePhoneNumberValueKey = 'updatePhoneNumber';
const String UpdateRoleValueKey = 'updateRole';

final Map<String, TextEditingController>
    _UpdateProfileSheetTextEditingControllers = {};

final Map<String, FocusNode> _UpdateProfileSheetFocusNodes = {};

final Map<String, String? Function(String?)?>
    _UpdateProfileSheetTextValidations = {
  UpdateUserNameValueKey: null,
  UpdateEmailValueKey: null,
  UpdatePhoneNumberValueKey: null,
  UpdateRoleValueKey: null,
};

mixin $UpdateProfileSheet {
  TextEditingController get updateUserNameController =>
      _getFormTextEditingController(UpdateUserNameValueKey);
  TextEditingController get updateEmailController =>
      _getFormTextEditingController(UpdateEmailValueKey);
  TextEditingController get updatePhoneNumberController =>
      _getFormTextEditingController(UpdatePhoneNumberValueKey);
  TextEditingController get updateRoleController =>
      _getFormTextEditingController(UpdateRoleValueKey);

  FocusNode get updateUserNameFocusNode =>
      _getFormFocusNode(UpdateUserNameValueKey);
  FocusNode get updateEmailFocusNode => _getFormFocusNode(UpdateEmailValueKey);
  FocusNode get updatePhoneNumberFocusNode =>
      _getFormFocusNode(UpdatePhoneNumberValueKey);
  FocusNode get updateRoleFocusNode => _getFormFocusNode(UpdateRoleValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_UpdateProfileSheetTextEditingControllers.containsKey(key)) {
      return _UpdateProfileSheetTextEditingControllers[key]!;
    }

    _UpdateProfileSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _UpdateProfileSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_UpdateProfileSheetFocusNodes.containsKey(key)) {
      return _UpdateProfileSheetFocusNodes[key]!;
    }
    _UpdateProfileSheetFocusNodes[key] = FocusNode();
    return _UpdateProfileSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    updateUserNameController.addListener(() => _updateFormData(model));
    updateEmailController.addListener(() => _updateFormData(model));
    updatePhoneNumberController.addListener(() => _updateFormData(model));
    updateRoleController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    updateUserNameController.addListener(() => _updateFormData(model));
    updateEmailController.addListener(() => _updateFormData(model));
    updatePhoneNumberController.addListener(() => _updateFormData(model));
    updateRoleController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          UpdateUserNameValueKey: updateUserNameController.text,
          UpdateEmailValueKey: updateEmailController.text,
          UpdatePhoneNumberValueKey: updatePhoneNumberController.text,
          UpdateRoleValueKey: updateRoleController.text,
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

    for (var controller in _UpdateProfileSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _UpdateProfileSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _UpdateProfileSheetTextEditingControllers.clear();
    _UpdateProfileSheetFocusNodes.clear();
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

  String? get updateUserNameValue =>
      this.formValueMap[UpdateUserNameValueKey] as String?;
  String? get updateEmailValue =>
      this.formValueMap[UpdateEmailValueKey] as String?;
  String? get updatePhoneNumberValue =>
      this.formValueMap[UpdatePhoneNumberValueKey] as String?;
  String? get updateRoleValue =>
      this.formValueMap[UpdateRoleValueKey] as String?;

  set updateUserNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UpdateUserNameValueKey: value}),
    );

    if (_UpdateProfileSheetTextEditingControllers.containsKey(
        UpdateUserNameValueKey)) {
      _UpdateProfileSheetTextEditingControllers[UpdateUserNameValueKey]?.text =
          value ?? '';
    }
  }

  set updateEmailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UpdateEmailValueKey: value}),
    );

    if (_UpdateProfileSheetTextEditingControllers.containsKey(
        UpdateEmailValueKey)) {
      _UpdateProfileSheetTextEditingControllers[UpdateEmailValueKey]?.text =
          value ?? '';
    }
  }

  set updatePhoneNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UpdatePhoneNumberValueKey: value}),
    );

    if (_UpdateProfileSheetTextEditingControllers.containsKey(
        UpdatePhoneNumberValueKey)) {
      _UpdateProfileSheetTextEditingControllers[UpdatePhoneNumberValueKey]
          ?.text = value ?? '';
    }
  }

  set updateRoleValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UpdateRoleValueKey: value}),
    );

    if (_UpdateProfileSheetTextEditingControllers.containsKey(
        UpdateRoleValueKey)) {
      _UpdateProfileSheetTextEditingControllers[UpdateRoleValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasUpdateUserName =>
      this.formValueMap.containsKey(UpdateUserNameValueKey) &&
      (updateUserNameValue?.isNotEmpty ?? false);
  bool get hasUpdateEmail =>
      this.formValueMap.containsKey(UpdateEmailValueKey) &&
      (updateEmailValue?.isNotEmpty ?? false);
  bool get hasUpdatePhoneNumber =>
      this.formValueMap.containsKey(UpdatePhoneNumberValueKey) &&
      (updatePhoneNumberValue?.isNotEmpty ?? false);
  bool get hasUpdateRole =>
      this.formValueMap.containsKey(UpdateRoleValueKey) &&
      (updateRoleValue?.isNotEmpty ?? false);

  bool get hasUpdateUserNameValidationMessage =>
      this.fieldsValidationMessages[UpdateUserNameValueKey]?.isNotEmpty ??
      false;
  bool get hasUpdateEmailValidationMessage =>
      this.fieldsValidationMessages[UpdateEmailValueKey]?.isNotEmpty ?? false;
  bool get hasUpdatePhoneNumberValidationMessage =>
      this.fieldsValidationMessages[UpdatePhoneNumberValueKey]?.isNotEmpty ??
      false;
  bool get hasUpdateRoleValidationMessage =>
      this.fieldsValidationMessages[UpdateRoleValueKey]?.isNotEmpty ?? false;

  String? get updateUserNameValidationMessage =>
      this.fieldsValidationMessages[UpdateUserNameValueKey];
  String? get updateEmailValidationMessage =>
      this.fieldsValidationMessages[UpdateEmailValueKey];
  String? get updatePhoneNumberValidationMessage =>
      this.fieldsValidationMessages[UpdatePhoneNumberValueKey];
  String? get updateRoleValidationMessage =>
      this.fieldsValidationMessages[UpdateRoleValueKey];
}

extension Methods on FormStateHelper {
  setUpdateUserNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdateUserNameValueKey] = validationMessage;
  setUpdateEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdateEmailValueKey] = validationMessage;
  setUpdatePhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdatePhoneNumberValueKey] =
          validationMessage;
  setUpdateRoleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UpdateRoleValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    updateUserNameValue = '';
    updateEmailValue = '';
    updatePhoneNumberValue = '';
    updateRoleValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      UpdateUserNameValueKey: getValidationMessage(UpdateUserNameValueKey),
      UpdateEmailValueKey: getValidationMessage(UpdateEmailValueKey),
      UpdatePhoneNumberValueKey:
          getValidationMessage(UpdatePhoneNumberValueKey),
      UpdateRoleValueKey: getValidationMessage(UpdateRoleValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _UpdateProfileSheetTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _UpdateProfileSheetTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      UpdateUserNameValueKey: getValidationMessage(UpdateUserNameValueKey),
      UpdateEmailValueKey: getValidationMessage(UpdateEmailValueKey),
      UpdatePhoneNumberValueKey:
          getValidationMessage(UpdatePhoneNumberValueKey),
      UpdateRoleValueKey: getValidationMessage(UpdateRoleValueKey),
    });
