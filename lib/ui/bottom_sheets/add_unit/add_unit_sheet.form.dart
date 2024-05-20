// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String UnitNameValueKey = 'UnitName';
const String UnitCodeValueKey = 'UnitCode';

final Map<String, TextEditingController> _AddUnitSheetTextEditingControllers =
    {};

final Map<String, FocusNode> _AddUnitSheetFocusNodes = {};

final Map<String, String? Function(String?)?> _AddUnitSheetTextValidations = {
  UnitNameValueKey: null,
  UnitCodeValueKey: null,
};

mixin $AddUnitSheet {
  TextEditingController get unitNameController =>
      _getFormTextEditingController(UnitNameValueKey);
  TextEditingController get unitCodeController =>
      _getFormTextEditingController(UnitCodeValueKey);

  FocusNode get unitNameFocusNode => _getFormFocusNode(UnitNameValueKey);
  FocusNode get unitCodeFocusNode => _getFormFocusNode(UnitCodeValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddUnitSheetTextEditingControllers.containsKey(key)) {
      return _AddUnitSheetTextEditingControllers[key]!;
    }

    _AddUnitSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddUnitSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddUnitSheetFocusNodes.containsKey(key)) {
      return _AddUnitSheetFocusNodes[key]!;
    }
    _AddUnitSheetFocusNodes[key] = FocusNode();
    return _AddUnitSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    unitNameController.addListener(() => _updateFormData(model));
    unitCodeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    unitNameController.addListener(() => _updateFormData(model));
    unitCodeController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          UnitNameValueKey: unitNameController.text,
          UnitCodeValueKey: unitCodeController.text,
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

    for (var controller in _AddUnitSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddUnitSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _AddUnitSheetTextEditingControllers.clear();
    _AddUnitSheetFocusNodes.clear();
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

  String? get unitNameValue => this.formValueMap[UnitNameValueKey] as String?;
  String? get unitCodeValue => this.formValueMap[UnitCodeValueKey] as String?;

  set unitNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UnitNameValueKey: value}),
    );

    if (_AddUnitSheetTextEditingControllers.containsKey(UnitNameValueKey)) {
      _AddUnitSheetTextEditingControllers[UnitNameValueKey]?.text = value ?? '';
    }
  }

  set unitCodeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UnitCodeValueKey: value}),
    );

    if (_AddUnitSheetTextEditingControllers.containsKey(UnitCodeValueKey)) {
      _AddUnitSheetTextEditingControllers[UnitCodeValueKey]?.text = value ?? '';
    }
  }

  bool get hasUnitName =>
      this.formValueMap.containsKey(UnitNameValueKey) &&
      (unitNameValue?.isNotEmpty ?? false);
  bool get hasUnitCode =>
      this.formValueMap.containsKey(UnitCodeValueKey) &&
      (unitCodeValue?.isNotEmpty ?? false);

  bool get hasUnitNameValidationMessage =>
      this.fieldsValidationMessages[UnitNameValueKey]?.isNotEmpty ?? false;
  bool get hasUnitCodeValidationMessage =>
      this.fieldsValidationMessages[UnitCodeValueKey]?.isNotEmpty ?? false;

  String? get unitNameValidationMessage =>
      this.fieldsValidationMessages[UnitNameValueKey];
  String? get unitCodeValidationMessage =>
      this.fieldsValidationMessages[UnitCodeValueKey];
}

extension Methods on FormStateHelper {
  setUnitNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UnitNameValueKey] = validationMessage;
  setUnitCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UnitCodeValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    unitNameValue = '';
    unitCodeValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      UnitNameValueKey: getValidationMessage(UnitNameValueKey),
      UnitCodeValueKey: getValidationMessage(UnitCodeValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddUnitSheetTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddUnitSheetTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      UnitNameValueKey: getValidationMessage(UnitNameValueKey),
      UnitCodeValueKey: getValidationMessage(UnitCodeValueKey),
    });
