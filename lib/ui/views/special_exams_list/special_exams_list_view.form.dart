// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchSpecialExamsValueKey = 'searchSpecialExams';

final Map<String, TextEditingController>
    _SpecialExamsListViewTextEditingControllers = {};

final Map<String, FocusNode> _SpecialExamsListViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _SpecialExamsListViewTextValidations = {
  SearchSpecialExamsValueKey: null,
};

mixin $SpecialExamsListView {
  TextEditingController get searchSpecialExamsController =>
      _getFormTextEditingController(SearchSpecialExamsValueKey);

  FocusNode get searchSpecialExamsFocusNode =>
      _getFormFocusNode(SearchSpecialExamsValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_SpecialExamsListViewTextEditingControllers.containsKey(key)) {
      return _SpecialExamsListViewTextEditingControllers[key]!;
    }

    _SpecialExamsListViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _SpecialExamsListViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_SpecialExamsListViewFocusNodes.containsKey(key)) {
      return _SpecialExamsListViewFocusNodes[key]!;
    }
    _SpecialExamsListViewFocusNodes[key] = FocusNode();
    return _SpecialExamsListViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    searchSpecialExamsController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    searchSpecialExamsController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchSpecialExamsValueKey: searchSpecialExamsController.text,
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

    for (var controller in _SpecialExamsListViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _SpecialExamsListViewFocusNodes.values) {
      focusNode.dispose();
    }

    _SpecialExamsListViewTextEditingControllers.clear();
    _SpecialExamsListViewFocusNodes.clear();
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

  String? get searchSpecialExamsValue =>
      this.formValueMap[SearchSpecialExamsValueKey] as String?;

  set searchSpecialExamsValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchSpecialExamsValueKey: value}),
    );

    if (_SpecialExamsListViewTextEditingControllers.containsKey(
        SearchSpecialExamsValueKey)) {
      _SpecialExamsListViewTextEditingControllers[SearchSpecialExamsValueKey]
          ?.text = value ?? '';
    }
  }

  bool get hasSearchSpecialExams =>
      this.formValueMap.containsKey(SearchSpecialExamsValueKey) &&
      (searchSpecialExamsValue?.isNotEmpty ?? false);

  bool get hasSearchSpecialExamsValidationMessage =>
      this.fieldsValidationMessages[SearchSpecialExamsValueKey]?.isNotEmpty ??
      false;

  String? get searchSpecialExamsValidationMessage =>
      this.fieldsValidationMessages[SearchSpecialExamsValueKey];
}

extension Methods on FormStateHelper {
  setSearchSpecialExamsValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchSpecialExamsValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    searchSpecialExamsValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SearchSpecialExamsValueKey:
          getValidationMessage(SearchSpecialExamsValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _SpecialExamsListViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _SpecialExamsListViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SearchSpecialExamsValueKey:
          getValidationMessage(SearchSpecialExamsValueKey),
    });
