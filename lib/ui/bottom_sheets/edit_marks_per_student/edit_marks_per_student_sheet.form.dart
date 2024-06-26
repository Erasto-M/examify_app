// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String AssignMent1MarksValueKey = 'assignMent1Marks';
const String AssignMent2MarksValueKey = 'assignMent2Marks';
const String Cat1MarksValueKey = 'cat1Marks';
const String Cat2MarksValueKey = 'cat2Marks';
const String ExamMarksValueKey = 'examMarks';

final Map<String, TextEditingController>
    _EditMarksPerStudentSheetTextEditingControllers = {};

final Map<String, FocusNode> _EditMarksPerStudentSheetFocusNodes = {};

final Map<String, String? Function(String?)?>
    _EditMarksPerStudentSheetTextValidations = {
  AssignMent1MarksValueKey: null,
  AssignMent2MarksValueKey: null,
  Cat1MarksValueKey: null,
  Cat2MarksValueKey: null,
  ExamMarksValueKey: null,
};

mixin $EditMarksPerStudentSheet {
  TextEditingController get assignMent1MarksController =>
      _getFormTextEditingController(AssignMent1MarksValueKey);
  TextEditingController get assignMent2MarksController =>
      _getFormTextEditingController(AssignMent2MarksValueKey);
  TextEditingController get cat1MarksController =>
      _getFormTextEditingController(Cat1MarksValueKey);
  TextEditingController get cat2MarksController =>
      _getFormTextEditingController(Cat2MarksValueKey);
  TextEditingController get examMarksController =>
      _getFormTextEditingController(ExamMarksValueKey);

  FocusNode get assignMent1MarksFocusNode =>
      _getFormFocusNode(AssignMent1MarksValueKey);
  FocusNode get assignMent2MarksFocusNode =>
      _getFormFocusNode(AssignMent2MarksValueKey);
  FocusNode get cat1MarksFocusNode => _getFormFocusNode(Cat1MarksValueKey);
  FocusNode get cat2MarksFocusNode => _getFormFocusNode(Cat2MarksValueKey);
  FocusNode get examMarksFocusNode => _getFormFocusNode(ExamMarksValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_EditMarksPerStudentSheetTextEditingControllers.containsKey(key)) {
      return _EditMarksPerStudentSheetTextEditingControllers[key]!;
    }

    _EditMarksPerStudentSheetTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _EditMarksPerStudentSheetTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_EditMarksPerStudentSheetFocusNodes.containsKey(key)) {
      return _EditMarksPerStudentSheetFocusNodes[key]!;
    }
    _EditMarksPerStudentSheetFocusNodes[key] = FocusNode();
    return _EditMarksPerStudentSheetFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    assignMent1MarksController.addListener(() => _updateFormData(model));
    assignMent2MarksController.addListener(() => _updateFormData(model));
    cat1MarksController.addListener(() => _updateFormData(model));
    cat2MarksController.addListener(() => _updateFormData(model));
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
    assignMent1MarksController.addListener(() => _updateFormData(model));
    assignMent2MarksController.addListener(() => _updateFormData(model));
    cat1MarksController.addListener(() => _updateFormData(model));
    cat2MarksController.addListener(() => _updateFormData(model));
    examMarksController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          AssignMent1MarksValueKey: assignMent1MarksController.text,
          AssignMent2MarksValueKey: assignMent2MarksController.text,
          Cat1MarksValueKey: cat1MarksController.text,
          Cat2MarksValueKey: cat2MarksController.text,
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
        in _EditMarksPerStudentSheetTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _EditMarksPerStudentSheetFocusNodes.values) {
      focusNode.dispose();
    }

    _EditMarksPerStudentSheetTextEditingControllers.clear();
    _EditMarksPerStudentSheetFocusNodes.clear();
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

  String? get assignMent1MarksValue =>
      this.formValueMap[AssignMent1MarksValueKey] as String?;
  String? get assignMent2MarksValue =>
      this.formValueMap[AssignMent2MarksValueKey] as String?;
  String? get cat1MarksValue => this.formValueMap[Cat1MarksValueKey] as String?;
  String? get cat2MarksValue => this.formValueMap[Cat2MarksValueKey] as String?;
  String? get examMarksValue => this.formValueMap[ExamMarksValueKey] as String?;

  set assignMent1MarksValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AssignMent1MarksValueKey: value}),
    );

    if (_EditMarksPerStudentSheetTextEditingControllers.containsKey(
        AssignMent1MarksValueKey)) {
      _EditMarksPerStudentSheetTextEditingControllers[AssignMent1MarksValueKey]
          ?.text = value ?? '';
    }
  }

  set assignMent2MarksValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AssignMent2MarksValueKey: value}),
    );

    if (_EditMarksPerStudentSheetTextEditingControllers.containsKey(
        AssignMent2MarksValueKey)) {
      _EditMarksPerStudentSheetTextEditingControllers[AssignMent2MarksValueKey]
          ?.text = value ?? '';
    }
  }

  set cat1MarksValue(String? value) {
    this.setData(
      this.formValueMap..addAll({Cat1MarksValueKey: value}),
    );

    if (_EditMarksPerStudentSheetTextEditingControllers.containsKey(
        Cat1MarksValueKey)) {
      _EditMarksPerStudentSheetTextEditingControllers[Cat1MarksValueKey]?.text =
          value ?? '';
    }
  }

  set cat2MarksValue(String? value) {
    this.setData(
      this.formValueMap..addAll({Cat2MarksValueKey: value}),
    );

    if (_EditMarksPerStudentSheetTextEditingControllers.containsKey(
        Cat2MarksValueKey)) {
      _EditMarksPerStudentSheetTextEditingControllers[Cat2MarksValueKey]?.text =
          value ?? '';
    }
  }

  set examMarksValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ExamMarksValueKey: value}),
    );

    if (_EditMarksPerStudentSheetTextEditingControllers.containsKey(
        ExamMarksValueKey)) {
      _EditMarksPerStudentSheetTextEditingControllers[ExamMarksValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasAssignMent1Marks =>
      this.formValueMap.containsKey(AssignMent1MarksValueKey) &&
      (assignMent1MarksValue?.isNotEmpty ?? false);
  bool get hasAssignMent2Marks =>
      this.formValueMap.containsKey(AssignMent2MarksValueKey) &&
      (assignMent2MarksValue?.isNotEmpty ?? false);
  bool get hasCat1Marks =>
      this.formValueMap.containsKey(Cat1MarksValueKey) &&
      (cat1MarksValue?.isNotEmpty ?? false);
  bool get hasCat2Marks =>
      this.formValueMap.containsKey(Cat2MarksValueKey) &&
      (cat2MarksValue?.isNotEmpty ?? false);
  bool get hasExamMarks =>
      this.formValueMap.containsKey(ExamMarksValueKey) &&
      (examMarksValue?.isNotEmpty ?? false);

  bool get hasAssignMent1MarksValidationMessage =>
      this.fieldsValidationMessages[AssignMent1MarksValueKey]?.isNotEmpty ??
      false;
  bool get hasAssignMent2MarksValidationMessage =>
      this.fieldsValidationMessages[AssignMent2MarksValueKey]?.isNotEmpty ??
      false;
  bool get hasCat1MarksValidationMessage =>
      this.fieldsValidationMessages[Cat1MarksValueKey]?.isNotEmpty ?? false;
  bool get hasCat2MarksValidationMessage =>
      this.fieldsValidationMessages[Cat2MarksValueKey]?.isNotEmpty ?? false;
  bool get hasExamMarksValidationMessage =>
      this.fieldsValidationMessages[ExamMarksValueKey]?.isNotEmpty ?? false;

  String? get assignMent1MarksValidationMessage =>
      this.fieldsValidationMessages[AssignMent1MarksValueKey];
  String? get assignMent2MarksValidationMessage =>
      this.fieldsValidationMessages[AssignMent2MarksValueKey];
  String? get cat1MarksValidationMessage =>
      this.fieldsValidationMessages[Cat1MarksValueKey];
  String? get cat2MarksValidationMessage =>
      this.fieldsValidationMessages[Cat2MarksValueKey];
  String? get examMarksValidationMessage =>
      this.fieldsValidationMessages[ExamMarksValueKey];
}

extension Methods on FormStateHelper {
  setAssignMent1MarksValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AssignMent1MarksValueKey] =
          validationMessage;
  setAssignMent2MarksValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AssignMent2MarksValueKey] =
          validationMessage;
  setCat1MarksValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Cat1MarksValueKey] = validationMessage;
  setCat2MarksValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[Cat2MarksValueKey] = validationMessage;
  setExamMarksValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ExamMarksValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    assignMent1MarksValue = '';
    assignMent2MarksValue = '';
    cat1MarksValue = '';
    cat2MarksValue = '';
    examMarksValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      AssignMent1MarksValueKey: getValidationMessage(AssignMent1MarksValueKey),
      AssignMent2MarksValueKey: getValidationMessage(AssignMent2MarksValueKey),
      Cat1MarksValueKey: getValidationMessage(Cat1MarksValueKey),
      Cat2MarksValueKey: getValidationMessage(Cat2MarksValueKey),
      ExamMarksValueKey: getValidationMessage(ExamMarksValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _EditMarksPerStudentSheetTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _EditMarksPerStudentSheetTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      AssignMent1MarksValueKey: getValidationMessage(AssignMent1MarksValueKey),
      AssignMent2MarksValueKey: getValidationMessage(AssignMent2MarksValueKey),
      Cat1MarksValueKey: getValidationMessage(Cat1MarksValueKey),
      Cat2MarksValueKey: getValidationMessage(Cat2MarksValueKey),
      ExamMarksValueKey: getValidationMessage(ExamMarksValueKey),
    });
