// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String NameValueKey = 'Name';
const String EmailValueKey = 'Email';
const String PhoneNumberValueKey = 'Phone Number';
const String GenderValueKey = 'Gender';
const String RoleValueKey = 'Role';
const String RegistrationNumberValueKey = 'Registration Number';
const String CohortValueKey = 'Cohort';
const String PFNumberValueKey = 'PF Number';
const String PasswordValueKey = 'Password';
const String YearOfStudyValueKey = 'Year of study';
const String ConfirmPasswordValueKey = 'Confirm Password';

final Map<String, TextEditingController> _RegisterViewTextEditingControllers =
    {};

final Map<String, FocusNode> _RegisterViewFocusNodes = {};

final Map<String, String? Function(String?)?> _RegisterViewTextValidations = {
  NameValueKey: null,
  EmailValueKey: null,
  PhoneNumberValueKey: null,
  GenderValueKey: null,
  RoleValueKey: null,
  RegistrationNumberValueKey: null,
  CohortValueKey: null,
  PFNumberValueKey: null,
  PasswordValueKey: null,
  YearOfStudyValueKey: null,
  ConfirmPasswordValueKey: null,
};

mixin $RegisterView {
  TextEditingController get nameController =>
      _getFormTextEditingController(NameValueKey);
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  TextEditingController get phoneNumberController =>
      _getFormTextEditingController(PhoneNumberValueKey);
  TextEditingController get genderController =>
      _getFormTextEditingController(GenderValueKey);
  TextEditingController get roleController =>
      _getFormTextEditingController(RoleValueKey);
  TextEditingController get registrationNumberController =>
      _getFormTextEditingController(RegistrationNumberValueKey);
  TextEditingController get cohortController =>
      _getFormTextEditingController(CohortValueKey);
  TextEditingController get pFNumberController =>
      _getFormTextEditingController(PFNumberValueKey);
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);
  TextEditingController get yearOfStudyController =>
      _getFormTextEditingController(YearOfStudyValueKey);
  TextEditingController get confirmPasswordController =>
      _getFormTextEditingController(ConfirmPasswordValueKey);

  FocusNode get nameFocusNode => _getFormFocusNode(NameValueKey);
  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get phoneNumberFocusNode => _getFormFocusNode(PhoneNumberValueKey);
  FocusNode get genderFocusNode => _getFormFocusNode(GenderValueKey);
  FocusNode get roleFocusNode => _getFormFocusNode(RoleValueKey);
  FocusNode get registrationNumberFocusNode =>
      _getFormFocusNode(RegistrationNumberValueKey);
  FocusNode get cohortFocusNode => _getFormFocusNode(CohortValueKey);
  FocusNode get pFNumberFocusNode => _getFormFocusNode(PFNumberValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);
  FocusNode get yearOfStudyFocusNode => _getFormFocusNode(YearOfStudyValueKey);
  FocusNode get confirmPasswordFocusNode =>
      _getFormFocusNode(ConfirmPasswordValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_RegisterViewTextEditingControllers.containsKey(key)) {
      return _RegisterViewTextEditingControllers[key]!;
    }

    _RegisterViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _RegisterViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_RegisterViewFocusNodes.containsKey(key)) {
      return _RegisterViewFocusNodes[key]!;
    }
    _RegisterViewFocusNodes[key] = FocusNode();
    return _RegisterViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    nameController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));
    genderController.addListener(() => _updateFormData(model));
    roleController.addListener(() => _updateFormData(model));
    registrationNumberController.addListener(() => _updateFormData(model));
    cohortController.addListener(() => _updateFormData(model));
    pFNumberController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    yearOfStudyController.addListener(() => _updateFormData(model));
    confirmPasswordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));
    genderController.addListener(() => _updateFormData(model));
    roleController.addListener(() => _updateFormData(model));
    registrationNumberController.addListener(() => _updateFormData(model));
    cohortController.addListener(() => _updateFormData(model));
    pFNumberController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    yearOfStudyController.addListener(() => _updateFormData(model));
    confirmPasswordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          NameValueKey: nameController.text,
          EmailValueKey: emailController.text,
          PhoneNumberValueKey: phoneNumberController.text,
          GenderValueKey: genderController.text,
          RoleValueKey: roleController.text,
          RegistrationNumberValueKey: registrationNumberController.text,
          CohortValueKey: cohortController.text,
          PFNumberValueKey: pFNumberController.text,
          PasswordValueKey: passwordController.text,
          YearOfStudyValueKey: yearOfStudyController.text,
          ConfirmPasswordValueKey: confirmPasswordController.text,
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

    for (var controller in _RegisterViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _RegisterViewFocusNodes.values) {
      focusNode.dispose();
    }

    _RegisterViewTextEditingControllers.clear();
    _RegisterViewFocusNodes.clear();
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

  String? get nameValue => this.formValueMap[NameValueKey] as String?;
  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get phoneNumberValue =>
      this.formValueMap[PhoneNumberValueKey] as String?;
  String? get genderValue => this.formValueMap[GenderValueKey] as String?;
  String? get roleValue => this.formValueMap[RoleValueKey] as String?;
  String? get registrationNumberValue =>
      this.formValueMap[RegistrationNumberValueKey] as String?;
  String? get cohortValue => this.formValueMap[CohortValueKey] as String?;
  String? get pFNumberValue => this.formValueMap[PFNumberValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get yearOfStudyValue =>
      this.formValueMap[YearOfStudyValueKey] as String?;
  String? get confirmPasswordValue =>
      this.formValueMap[ConfirmPasswordValueKey] as String?;

  set nameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({NameValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(NameValueKey)) {
      _RegisterViewTextEditingControllers[NameValueKey]?.text = value ?? '';
    }
  }

  set emailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(EmailValueKey)) {
      _RegisterViewTextEditingControllers[EmailValueKey]?.text = value ?? '';
    }
  }

  set phoneNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneNumberValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(PhoneNumberValueKey)) {
      _RegisterViewTextEditingControllers[PhoneNumberValueKey]?.text =
          value ?? '';
    }
  }

  set genderValue(String? value) {
    this.setData(
      this.formValueMap..addAll({GenderValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(GenderValueKey)) {
      _RegisterViewTextEditingControllers[GenderValueKey]?.text = value ?? '';
    }
  }

  set roleValue(String? value) {
    this.setData(
      this.formValueMap..addAll({RoleValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(RoleValueKey)) {
      _RegisterViewTextEditingControllers[RoleValueKey]?.text = value ?? '';
    }
  }

  set registrationNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({RegistrationNumberValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(
        RegistrationNumberValueKey)) {
      _RegisterViewTextEditingControllers[RegistrationNumberValueKey]?.text =
          value ?? '';
    }
  }

  set cohortValue(String? value) {
    this.setData(
      this.formValueMap..addAll({CohortValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(CohortValueKey)) {
      _RegisterViewTextEditingControllers[CohortValueKey]?.text = value ?? '';
    }
  }

  set pFNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PFNumberValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(PFNumberValueKey)) {
      _RegisterViewTextEditingControllers[PFNumberValueKey]?.text = value ?? '';
    }
  }

  set passwordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PasswordValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(PasswordValueKey)) {
      _RegisterViewTextEditingControllers[PasswordValueKey]?.text = value ?? '';
    }
  }

  set yearOfStudyValue(String? value) {
    this.setData(
      this.formValueMap..addAll({YearOfStudyValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(YearOfStudyValueKey)) {
      _RegisterViewTextEditingControllers[YearOfStudyValueKey]?.text =
          value ?? '';
    }
  }

  set confirmPasswordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ConfirmPasswordValueKey: value}),
    );

    if (_RegisterViewTextEditingControllers.containsKey(
        ConfirmPasswordValueKey)) {
      _RegisterViewTextEditingControllers[ConfirmPasswordValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasName =>
      this.formValueMap.containsKey(NameValueKey) &&
      (nameValue?.isNotEmpty ?? false);
  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasPhoneNumber =>
      this.formValueMap.containsKey(PhoneNumberValueKey) &&
      (phoneNumberValue?.isNotEmpty ?? false);
  bool get hasGender =>
      this.formValueMap.containsKey(GenderValueKey) &&
      (genderValue?.isNotEmpty ?? false);
  bool get hasRole =>
      this.formValueMap.containsKey(RoleValueKey) &&
      (roleValue?.isNotEmpty ?? false);
  bool get hasRegistrationNumber =>
      this.formValueMap.containsKey(RegistrationNumberValueKey) &&
      (registrationNumberValue?.isNotEmpty ?? false);
  bool get hasCohort =>
      this.formValueMap.containsKey(CohortValueKey) &&
      (cohortValue?.isNotEmpty ?? false);
  bool get hasPFNumber =>
      this.formValueMap.containsKey(PFNumberValueKey) &&
      (pFNumberValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);
  bool get hasYearOfStudy =>
      this.formValueMap.containsKey(YearOfStudyValueKey) &&
      (yearOfStudyValue?.isNotEmpty ?? false);
  bool get hasConfirmPassword =>
      this.formValueMap.containsKey(ConfirmPasswordValueKey) &&
      (confirmPasswordValue?.isNotEmpty ?? false);

  bool get hasNameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey]?.isNotEmpty ?? false;
  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey]?.isNotEmpty ?? false;
  bool get hasGenderValidationMessage =>
      this.fieldsValidationMessages[GenderValueKey]?.isNotEmpty ?? false;
  bool get hasRoleValidationMessage =>
      this.fieldsValidationMessages[RoleValueKey]?.isNotEmpty ?? false;
  bool get hasRegistrationNumberValidationMessage =>
      this.fieldsValidationMessages[RegistrationNumberValueKey]?.isNotEmpty ??
      false;
  bool get hasCohortValidationMessage =>
      this.fieldsValidationMessages[CohortValueKey]?.isNotEmpty ?? false;
  bool get hasPFNumberValidationMessage =>
      this.fieldsValidationMessages[PFNumberValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;
  bool get hasYearOfStudyValidationMessage =>
      this.fieldsValidationMessages[YearOfStudyValueKey]?.isNotEmpty ?? false;
  bool get hasConfirmPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey]?.isNotEmpty ??
      false;

  String? get nameValidationMessage =>
      this.fieldsValidationMessages[NameValueKey];
  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get phoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey];
  String? get genderValidationMessage =>
      this.fieldsValidationMessages[GenderValueKey];
  String? get roleValidationMessage =>
      this.fieldsValidationMessages[RoleValueKey];
  String? get registrationNumberValidationMessage =>
      this.fieldsValidationMessages[RegistrationNumberValueKey];
  String? get cohortValidationMessage =>
      this.fieldsValidationMessages[CohortValueKey];
  String? get pFNumberValidationMessage =>
      this.fieldsValidationMessages[PFNumberValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
  String? get yearOfStudyValidationMessage =>
      this.fieldsValidationMessages[YearOfStudyValueKey];
  String? get confirmPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey];
}

extension Methods on FormStateHelper {
  setNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NameValueKey] = validationMessage;
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setPhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneNumberValueKey] = validationMessage;
  setGenderValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[GenderValueKey] = validationMessage;
  setRoleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RoleValueKey] = validationMessage;
  setRegistrationNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RegistrationNumberValueKey] =
          validationMessage;
  setCohortValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CohortValueKey] = validationMessage;
  setPFNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PFNumberValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
  setYearOfStudyValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[YearOfStudyValueKey] = validationMessage;
  setConfirmPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    nameValue = '';
    emailValue = '';
    phoneNumberValue = '';
    genderValue = '';
    roleValue = '';
    registrationNumberValue = '';
    cohortValue = '';
    pFNumberValue = '';
    passwordValue = '';
    yearOfStudyValue = '';
    confirmPasswordValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      GenderValueKey: getValidationMessage(GenderValueKey),
      RoleValueKey: getValidationMessage(RoleValueKey),
      RegistrationNumberValueKey:
          getValidationMessage(RegistrationNumberValueKey),
      CohortValueKey: getValidationMessage(CohortValueKey),
      PFNumberValueKey: getValidationMessage(PFNumberValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      YearOfStudyValueKey: getValidationMessage(YearOfStudyValueKey),
      ConfirmPasswordValueKey: getValidationMessage(ConfirmPasswordValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _RegisterViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _RegisterViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      NameValueKey: getValidationMessage(NameValueKey),
      EmailValueKey: getValidationMessage(EmailValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
      GenderValueKey: getValidationMessage(GenderValueKey),
      RoleValueKey: getValidationMessage(RoleValueKey),
      RegistrationNumberValueKey:
          getValidationMessage(RegistrationNumberValueKey),
      CohortValueKey: getValidationMessage(CohortValueKey),
      PFNumberValueKey: getValidationMessage(PFNumberValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      YearOfStudyValueKey: getValidationMessage(YearOfStudyValueKey),
      ConfirmPasswordValueKey: getValidationMessage(ConfirmPasswordValueKey),
    });
