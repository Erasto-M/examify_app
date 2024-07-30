// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String Assignment1OutofValueKey = 'assignment1Outof';
const String Assignment2OutofValueKey = 'assignment2Outof';
const String Cat1OutofValueKey = 'cat1Outof';
const String Cat2OutofValueKey = 'cat2Outof';
const String MainExamOutofValueKey = 'mainExamOutof';

final Map<String, TextEditingController>
    _CustomizeUnitsAssesmentSheetTextEditingControllers = {};

final Map<String, FocusNode> _CustomizeUnitsAssesmentSheetFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CustomizeUnitsAssesmentSheetTextValidations = {
  Assignment1OutofValueKey: null,
  Assignment2OutofValueKey: null,
  Cat1OutofValueKey: null,
  Cat2OutofValueKey: null,
  MainExamOutofValueKey: null,
};

mixin $CustomizeUnitsAssesmentSheet {
  TextEditingController get assignment1OutofController =>
      _getFormTextEditingController(Assignment1OutofValueKey);
  TextEditingController get assignment2OutofController =>
      _getFormTextEditingController(Assignment2OutofValueKey);
  TextEditingController get cat1OutofController =>
      _getFormTextEditingController(Cat1OutofValueKey);
  TextEditingController get cat2OutofController =>
      _getFormTextEditingController(Cat2OutofValueKey);
  TextEditingController get mainExamOutofController =>
      _getFormTextEditingController(MainExamOutofValueKey);

  FocusNode get assignment1OutofFocusNode =>
      _getFormFocusNode(Assignment1OutofValueKey);
  FocusNode get assignment2OutofFocusNode =>
      _getFormFocusNode(Assignment2OutofValueKey);
  FocusNode get cat1OutofFocusNode => _getFormFocusNode(Cat1OutofValueKey);
  FocusNode get cat2OutofFocusNode => _getFormFocusNode(Cat2OutofValueKey);
  FocusNode get mainExamOutofFocusNode =>
      _getFormFocusNode(MainExamOutofValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CustomizeUnitsAssesmentSheetTextEditingControllers.containsKey(key)) {
      return _CustomizeUnitsAssesmentSheetTextEditingControllers[key]!;
    }

    _CustomizeUnitsAssesmentSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CustomizeUnitsAssesmentSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CustomizeUnitsAssesmentSheetFocusNodes.containsKey(key)) {
      return _CustomizeUnitsAssesmentSheetFocusNodes[key]!;
    }
    _CustomizeUnitsAssesmentSheetFocusNodes[key] = FocusNode();
    return _CustomizeUnitsAssesmentSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    assignment1OutofController.addListener(() => _updateFormData(model));
    assignment2OutofController.addListener(() => _updateFormData(model));
    cat1OutofController.addListener(() => _updateFormData(model));
    cat2OutofController.addListener(() => _updateFormData(model));
    mainExamOutofController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    assignment1OutofController.addListener(() => _updateFormData(model));
    assignment2OutofController.addListener(() => _updateFormData(model));
    cat1OutofController.addListener(() => _updateFormData(model));
    cat2OutofController.addListener(() => _updateFormData(model));
    mainExamOutofController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          Assignment1OutofValueKey: assignment1OutofController.text,
          Assignment2OutofValueKey: assignment2OutofController.text,
          Cat1OutofValueKey: cat1OutofController.text,
          Cat2OutofValueKey: cat2OutofController.text,
          MainExamOutofValueKey: mainExamOutofController.text,
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
        in _CustomizeUnitsAssesmentSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CustomizeUnitsAssesmentSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _CustomizeUnitsAssesmentSheetTextEditingControllers.clear();
    _CustomizeUnitsAssesmentSheetFocusNodes.clear();
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

  String? get assignment1OutofValue =>
      this.formValueMap[Assignment1OutofValueKey] as String?;
  String? get assignment2OutofValue =>
      this.formValueMap[Assignment2OutofValueKey] as String?;
  String? get cat1OutofValue => this.formValueMap[Cat1OutofValueKey] as String?;
  String? get cat2OutofValue => this.formValueMap[Cat2OutofValueKey] as String?;
  String? get mainExamOutofValue =>
      this.formValueMap[MainExamOutofValueKey] as String?;

  set assignment1OutofValue(String? value) {
    this.setData(
      this.formValueMap..addAll({Assignment1OutofValueKey: value}),
    );

    if (_CustomizeUnitsAssesmentSheetTextEditingControllers.containsKey(
        Assignment1OutofValueKey)) {
      _CustomizeUnitsAssesmentSheetTextEditingControllers[
              Assignment1OutofValueKey]
          ?.text = value ?? '';
    }
  }

  set assignment2OutofValue(String? value) {
    this.setData(
      this.formValueMap..addAll({Assignment2OutofValueKey: value}),
    );

    if (_CustomizeUnitsAssesmentSheetTextEditingControllers.containsKey(
        Assignment2OutofValueKey)) {
      _CustomizeUnitsAssesmentSheetTextEditingControllers[
              Assignment2OutofValueKey]
          ?.text = value ?? '';
    }
  }

  set cat1OutofValue(String? value) {
    this.setData(
      this.formValueMap..addAll({Cat1OutofValueKey: value}),
    );

    if (_CustomizeUnitsAssesmentSheetTextEditingControllers.containsKey(
        Cat1OutofValueKey)) {
      _CustomizeUnitsAssesmentSheetTextEditingControllers[Cat1OutofValueKey]
          ?.text = value ?? '';
    }
  }

  set cat2OutofValue(String? value) {
    this.setData(
      this.formValueMap..addAll({Cat2OutofValueKey: value}),
    );

    if (_CustomizeUnitsAssesmentSheetTextEditingControllers.containsKey(
        Cat2OutofValueKey)) {
      _CustomizeUnitsAssesmentSheetTextEditingControllers[Cat2OutofValueKey]
          ?.text = value ?? '';
    }
  }

  set mainExamOutofValue(String? value) {
    this.setData(
      this.formValueMap..addAll({MainExamOutofValueKey: value}),
    );

    if (_CustomizeUnitsAssesmentSheetTextEditingControllers.containsKey(
        MainExamOutofValueKey)) {
      _CustomizeUnitsAssesmentSheetTextEditingControllers[MainExamOutofValueKey]
          ?.text = value ?? '';
    }
  }

  bool get hasAssignment1Outof =>
      this.formValueMap.containsKey(Assignment1OutofValueKey) &&
      (assignment1OutofValue?.isNotEmpty ?? false);
  bool get hasAssignment2Outof =>
      this.formValueMap.containsKey(Assignment2OutofValueKey) &&
      (assignment2OutofValue?.isNotEmpty ?? false);
  bool get hasCat1Outof =>
      this.formValueMap.containsKey(Cat1OutofValueKey) &&
      (cat1OutofValue?.isNotEmpty ?? false);
  bool get hasCat2Outof =>
      this.formValueMap.containsKey(Cat2OutofValueKey) &&
      (cat2OutofValue?.isNotEmpty ?? false);
  bool get hasMainExamOutof =>
      this.formValueMap.containsKey(MainExamOutofValueKey) &&
      (mainExamOutofValue?.isNotEmpty ?? false);

  bool get hasAssignment1OutofValidationMessage =>
      this.fieldsValidationMessages[Assignment1OutofValueKey]?.isNotEmpty ??
      false;
  bool get hasAssignment2OutofValidationMessage =>
      this.fieldsValidationMessages[Assignment2OutofValueKey]?.isNotEmpty ??
      false;
  bool get hasCat1OutofValidationMessage =>
      this.fieldsValidationMessages[Cat1OutofValueKey]?.isNotEmpty ?? false;
  bool get hasCat2OutofValidationMessage =>
      this.fieldsValidationMessages[Cat2OutofValueKey]?.isNotEmpty ?? false;
  bool get hasMainExamOutofValidationMessage =>
      this.fieldsValidationMessages[MainExamOutofValueKey]?.isNotEmpty ?? false;

  String? get assignment1OutofValidationMessage =>
      this.fieldsValidationMessages[Assignment1OutofValueKey];
  String? get assignment2OutofValidationMessage =>
      this.fieldsValidationMessages[Assignment2OutofValueKey];
  String? get cat1OutofValidationMessage =>
      this.fieldsValidationMessages[Cat1OutofValueKey];
  String? get cat2OutofValidationMessage =>
      this.fieldsValidationMessages[Cat2OutofValueKey];
  String? get mainExamOutofValidationMessage =>
      this.fieldsValidationMessages[MainExamOutofValueKey];
}

extension Methods on FormStateHelper {
  setAssignment1OutofValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Assignment1OutofValueKey] =
          validationMessage;
  setAssignment2OutofValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Assignment2OutofValueKey] =
          validationMessage;
  setCat1OutofValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Cat1OutofValueKey] = validationMessage;
  setCat2OutofValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Cat2OutofValueKey] = validationMessage;
  setMainExamOutofValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MainExamOutofValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    assignment1OutofValue = '';
    assignment2OutofValue = '';
    cat1OutofValue = '';
    cat2OutofValue = '';
    mainExamOutofValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      Assignment1OutofValueKey: getValidationMessage(Assignment1OutofValueKey),
      Assignment2OutofValueKey: getValidationMessage(Assignment2OutofValueKey),
      Cat1OutofValueKey: getValidationMessage(Cat1OutofValueKey),
      Cat2OutofValueKey: getValidationMessage(Cat2OutofValueKey),
      MainExamOutofValueKey: getValidationMessage(MainExamOutofValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CustomizeUnitsAssesmentSheetTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CustomizeUnitsAssesmentSheetTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      Assignment1OutofValueKey: getValidationMessage(Assignment1OutofValueKey),
      Assignment2OutofValueKey: getValidationMessage(Assignment2OutofValueKey),
      Cat1OutofValueKey: getValidationMessage(Cat1OutofValueKey),
      Cat2OutofValueKey: getValidationMessage(Cat2OutofValueKey),
      MainExamOutofValueKey: getValidationMessage(MainExamOutofValueKey),
    });
