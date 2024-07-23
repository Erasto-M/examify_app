// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchPasslistValueKey = 'searchPasslist';

final Map<String, TextEditingController> _PasslistViewTextEditingControllers =
    {};

final Map<String, FocusNode> _PasslistViewFocusNodes = {};

final Map<String, String? Function(String?)?> _PasslistViewTextValidations = {
  SearchPasslistValueKey: null,
};

mixin $PasslistView {
  TextEditingController get searchPasslistController =>
      _getFormTextEditingController(SearchPasslistValueKey);

  FocusNode get searchPasslistFocusNode =>
      _getFormFocusNode(SearchPasslistValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_PasslistViewTextEditingControllers.containsKey(key)) {
      return _PasslistViewTextEditingControllers[key]!;
    }

    _PasslistViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _PasslistViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_PasslistViewFocusNodes.containsKey(key)) {
      return _PasslistViewFocusNodes[key]!;
    }
    _PasslistViewFocusNodes[key] = FocusNode();
    return _PasslistViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    searchPasslistController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    searchPasslistController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchPasslistValueKey: searchPasslistController.text,
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

    for (var controller in _PasslistViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _PasslistViewFocusNodes.values) {
      focusNode.dispose();
    }

    _PasslistViewTextEditingControllers.clear();
    _PasslistViewFocusNodes.clear();
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

  String? get searchPasslistValue =>
      this.formValueMap[SearchPasslistValueKey] as String?;

  set searchPasslistValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchPasslistValueKey: value}),
    );

    if (_PasslistViewTextEditingControllers.containsKey(
        SearchPasslistValueKey)) {
      _PasslistViewTextEditingControllers[SearchPasslistValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasSearchPasslist =>
      this.formValueMap.containsKey(SearchPasslistValueKey) &&
      (searchPasslistValue?.isNotEmpty ?? false);

  bool get hasSearchPasslistValidationMessage =>
      this.fieldsValidationMessages[SearchPasslistValueKey]?.isNotEmpty ??
      false;

  String? get searchPasslistValidationMessage =>
      this.fieldsValidationMessages[SearchPasslistValueKey];
}

extension Methods on FormStateHelper {
  setSearchPasslistValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchPasslistValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    searchPasslistValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SearchPasslistValueKey: getValidationMessage(SearchPasslistValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _PasslistViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _PasslistViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SearchPasslistValueKey: getValidationMessage(SearchPasslistValueKey),
    });
