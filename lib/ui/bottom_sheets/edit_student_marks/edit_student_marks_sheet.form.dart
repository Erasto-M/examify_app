// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String Assignment1ValueKey = 'assignment1';
const String Assignment2ValueKey = 'assignment2';
const String Cat1ValueKey = 'cat1';
const String Cat2ValueKey = 'cat2';
const String ExamMarksValueKey = 'examMarks';

final Map<String, TextEditingController>
    _EditStudentMarksSheetTextEditingControllers = {};

final Map<String, FocusNode> _EditStudentMarksSheetFocusNodes = {};

final Map<String, String? Function(String?)?>
    _EditStudentMarksSheetTextValidations = {
  Assignment1ValueKey: null,
  Assignment2ValueKey: null,
  Cat1ValueKey: null,
  Cat2ValueKey: null,
  ExamMarksValueKey: null,
};

mixin $EditStudentMarksSheet {
  TextEditingController get assignment1Controller =>
      _getFormTextEditingController(Assignment1ValueKey);
  TextEditingController get assignment2Controller =>
      _getFormTextEditingController(Assignment2ValueKey);
  TextEditingController get cat1Controller =>
      _getFormTextEditingController(Cat1ValueKey);
  TextEditingController get cat2Controller =>
      _getFormTextEditingController(Cat2ValueKey);
  TextEditingController get examMarksController =>
      _getFormTextEditingController(ExamMarksValueKey);

  FocusNode get assignment1FocusNode => _getFormFocusNode(Assignment1ValueKey);
  FocusNode get assignment2FocusNode => _getFormFocusNode(Assignment2ValueKey);
  FocusNode get cat1FocusNode => _getFormFocusNode(Cat1ValueKey);
  FocusNode get cat2FocusNode => _getFormFocusNode(Cat2ValueKey);
  FocusNode get examMarksFocusNode => _getFormFocusNode(ExamMarksValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_EditStudentMarksSheetTextEditingControllers.containsKey(key)) {
      return _EditStudentMarksSheetTextEditingControllers[key]!;
    }

    _EditStudentMarksSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _EditStudentMarksSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_EditStudentMarksSheetFocusNodes.containsKey(key)) {
      return _EditStudentMarksSheetFocusNodes[key]!;
    }
    _EditStudentMarksSheetFocusNodes[key] = FocusNode();
    return _EditStudentMarksSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    assignment1Controller.addListener(() => _updateFormData(model));
    assignment2Controller.addListener(() => _updateFormData(model));
    cat1Controller.addListener(() => _updateFormData(model));
    cat2Controller.addListener(() => _updateFormData(model));
    examMarksController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    assignment1Controller.addListener(() => _updateFormData(model));
    assignment2Controller.addListener(() => _updateFormData(model));
    cat1Controller.addListener(() => _updateFormData(model));
    cat2Controller.addListener(() => _updateFormData(model));
    examMarksController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          Assignment1ValueKey: assignment1Controller.text,
          Assignment2ValueKey: assignment2Controller.text,
          Cat1ValueKey: cat1Controller.text,
          Cat2ValueKey: cat2Controller.text,
          ExamMarksValueKey: examMarksController.text,
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
        in _EditStudentMarksSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _EditStudentMarksSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _EditStudentMarksSheetTextEditingControllers.clear();
    _EditStudentMarksSheetFocusNodes.clear();
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

  String? get assignment1Value =>
      this.formValueMap[Assignment1ValueKey] as String?;
  String? get assignment2Value =>
      this.formValueMap[Assignment2ValueKey] as String?;
  String? get cat1Value => this.formValueMap[Cat1ValueKey] as String?;
  String? get cat2Value => this.formValueMap[Cat2ValueKey] as String?;
  String? get examMarksValue => this.formValueMap[ExamMarksValueKey] as String?;

  set assignment1Value(String? value) {
    this.setData(
      this.formValueMap..addAll({Assignment1ValueKey: value}),
    );

    if (_EditStudentMarksSheetTextEditingControllers.containsKey(
        Assignment1ValueKey)) {
      _EditStudentMarksSheetTextEditingControllers[Assignment1ValueKey]?.text =
          value ?? '';
    }
  }

  set assignment2Value(String? value) {
    this.setData(
      this.formValueMap..addAll({Assignment2ValueKey: value}),
    );

    if (_EditStudentMarksSheetTextEditingControllers.containsKey(
        Assignment2ValueKey)) {
      _EditStudentMarksSheetTextEditingControllers[Assignment2ValueKey]?.text =
          value ?? '';
    }
  }

  set cat1Value(String? value) {
    this.setData(
      this.formValueMap..addAll({Cat1ValueKey: value}),
    );

    if (_EditStudentMarksSheetTextEditingControllers.containsKey(
        Cat1ValueKey)) {
      _EditStudentMarksSheetTextEditingControllers[Cat1ValueKey]?.text =
          value ?? '';
    }
  }

  set cat2Value(String? value) {
    this.setData(
      this.formValueMap..addAll({Cat2ValueKey: value}),
    );

    if (_EditStudentMarksSheetTextEditingControllers.containsKey(
        Cat2ValueKey)) {
      _EditStudentMarksSheetTextEditingControllers[Cat2ValueKey]?.text =
          value ?? '';
    }
  }

  set examMarksValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ExamMarksValueKey: value}),
    );

    if (_EditStudentMarksSheetTextEditingControllers.containsKey(
        ExamMarksValueKey)) {
      _EditStudentMarksSheetTextEditingControllers[ExamMarksValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasAssignment1 =>
      this.formValueMap.containsKey(Assignment1ValueKey) &&
      (assignment1Value?.isNotEmpty ?? false);
  bool get hasAssignment2 =>
      this.formValueMap.containsKey(Assignment2ValueKey) &&
      (assignment2Value?.isNotEmpty ?? false);
  bool get hasCat1 =>
      this.formValueMap.containsKey(Cat1ValueKey) &&
      (cat1Value?.isNotEmpty ?? false);
  bool get hasCat2 =>
      this.formValueMap.containsKey(Cat2ValueKey) &&
      (cat2Value?.isNotEmpty ?? false);
  bool get hasExamMarks =>
      this.formValueMap.containsKey(ExamMarksValueKey) &&
      (examMarksValue?.isNotEmpty ?? false);

  bool get hasAssignment1ValidationMessage =>
      this.fieldsValidationMessages[Assignment1ValueKey]?.isNotEmpty ?? false;
  bool get hasAssignment2ValidationMessage =>
      this.fieldsValidationMessages[Assignment2ValueKey]?.isNotEmpty ?? false;
  bool get hasCat1ValidationMessage =>
      this.fieldsValidationMessages[Cat1ValueKey]?.isNotEmpty ?? false;
  bool get hasCat2ValidationMessage =>
      this.fieldsValidationMessages[Cat2ValueKey]?.isNotEmpty ?? false;
  bool get hasExamMarksValidationMessage =>
      this.fieldsValidationMessages[ExamMarksValueKey]?.isNotEmpty ?? false;

  String? get assignment1ValidationMessage =>
      this.fieldsValidationMessages[Assignment1ValueKey];
  String? get assignment2ValidationMessage =>
      this.fieldsValidationMessages[Assignment2ValueKey];
  String? get cat1ValidationMessage =>
      this.fieldsValidationMessages[Cat1ValueKey];
  String? get cat2ValidationMessage =>
      this.fieldsValidationMessages[Cat2ValueKey];
  String? get examMarksValidationMessage =>
      this.fieldsValidationMessages[ExamMarksValueKey];
}

extension Methods on FormStateHelper {
  setAssignment1ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Assignment1ValueKey] = validationMessage;
  setAssignment2ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Assignment2ValueKey] = validationMessage;
  setCat1ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Cat1ValueKey] = validationMessage;
  setCat2ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Cat2ValueKey] = validationMessage;
  setExamMarksValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ExamMarksValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    assignment1Value = '';
    assignment2Value = '';
    cat1Value = '';
    cat2Value = '';
    examMarksValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      Assignment1ValueKey: getValidationMessage(Assignment1ValueKey),
      Assignment2ValueKey: getValidationMessage(Assignment2ValueKey),
      Cat1ValueKey: getValidationMessage(Cat1ValueKey),
      Cat2ValueKey: getValidationMessage(Cat2ValueKey),
      ExamMarksValueKey: getValidationMessage(ExamMarksValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _EditStudentMarksSheetTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _EditStudentMarksSheetTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      Assignment1ValueKey: getValidationMessage(Assignment1ValueKey),
      Assignment2ValueKey: getValidationMessage(Assignment2ValueKey),
      Cat1ValueKey: getValidationMessage(Cat1ValueKey),
      Cat2ValueKey: getValidationMessage(Cat2ValueKey),
      ExamMarksValueKey: getValidationMessage(ExamMarksValueKey),
    });
