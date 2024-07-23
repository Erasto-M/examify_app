// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String SearchSupplistValueKey = 'searchSupplist';

final Map<String, TextEditingController> _SupplistViewTextEditingControllers =
    {};

final Map<String, FocusNode> _SupplistViewFocusNodes = {};

final Map<String, String? Function(String?)?> _SupplistViewTextValidations = {
  SearchSupplistValueKey: null,
};

mixin $SupplistView {
  TextEditingController get searchSupplistController =>
      _getFormTextEditingController(SearchSupplistValueKey);

  FocusNode get searchSupplistFocusNode =>
      _getFormFocusNode(SearchSupplistValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_SupplistViewTextEditingControllers.containsKey(key)) {
      return _SupplistViewTextEditingControllers[key]!;
    }

    _SupplistViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _SupplistViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_SupplistViewFocusNodes.containsKey(key)) {
      return _SupplistViewFocusNodes[key]!;
    }
    _SupplistViewFocusNodes[key] = FocusNode();
    return _SupplistViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    searchSupplistController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    searchSupplistController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchSupplistValueKey: searchSupplistController.text,
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

    for (var controller in _SupplistViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _SupplistViewFocusNodes.values) {
      focusNode.dispose();
    }

    _SupplistViewTextEditingControllers.clear();
    _SupplistViewFocusNodes.clear();
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

  String? get searchSupplistValue =>
      this.formValueMap[SearchSupplistValueKey] as String?;

  set searchSupplistValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SearchSupplistValueKey: value}),
    );

    if (_SupplistViewTextEditingControllers.containsKey(
        SearchSupplistValueKey)) {
      _SupplistViewTextEditingControllers[SearchSupplistValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasSearchSupplist =>
      this.formValueMap.containsKey(SearchSupplistValueKey) &&
      (searchSupplistValue?.isNotEmpty ?? false);

  bool get hasSearchSupplistValidationMessage =>
      this.fieldsValidationMessages[SearchSupplistValueKey]?.isNotEmpty ??
      false;

  String? get searchSupplistValidationMessage =>
      this.fieldsValidationMessages[SearchSupplistValueKey];
}

extension Methods on FormStateHelper {
  setSearchSupplistValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchSupplistValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    searchSupplistValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      SearchSupplistValueKey: getValidationMessage(SearchSupplistValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _SupplistViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _SupplistViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      SearchSupplistValueKey: getValidationMessage(SearchSupplistValueKey),
    });
