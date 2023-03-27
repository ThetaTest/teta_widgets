import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signin_w_credentials/action.dart';
import 'package:teta_widgets/src/elements/actions/supabase/signup_w_credentials/action.dart';

import '../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../core/teta_action/teta_action.dart';
import '../../../actions/supabase/delete/action.dart';
import '../../../actions/supabase/function_invoke/action.dart';
import '../../../actions/supabase/insert/action.dart';
import '../../../actions/supabase/signin_w_provider/action.dart';
import '../../../actions/supabase/storage_delete/action.dart';
import '../../../actions/supabase/storage_upload/action.dart';
import '../../../actions/supabase/update/action.dart';
import 'widget/auth/signin_w_credentials.dart';
import 'widget/auth/signin_w_provider.dart';
import 'widget/auth/signup_w_credentials.dart';
import 'widget/database/delete.dart';
import 'widget/database/insert.dart';
import 'widget/database/update.dart';
import 'widget/invoke.dart';
import 'widget/storage/delete.dart';
import 'widget/storage/upload.dart';

class TASupabaseControl extends StatelessWidget {
  const TASupabaseControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TetaAction action;
  final Function(TetaActionParams params) onParamsChanged;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (action is TASupabaseSignInWithCredentials)
          SupabaseSigninWCredentialsControl(
            action: action as TASupabaseSignInWithCredentials,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TASupabaseSignUp)
          SupabaseSignUpWCredentialsControl(
            action: action as TASupabaseSignUp,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TASupabaseSignInWithProvider)
          SupabaseSignInWProviderControl(
            action: action as TASupabaseSignInWithProvider,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TASupabaseStorageDelete)
          SupabaseStorageDeleteControl(
            action: action as TASupabaseStorageDelete,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TASupabaseStorageUpload)
          SupabaseStorageUploadControl(
            action: action as TASupabaseStorageUpload,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TASupabaseUpdate)
          SupabaseUpdateControl(
            action: action as TASupabaseUpdate,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TASupabaseDelete)
          SupabaseDeleteControl(
            action: action as TASupabaseDelete,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TASupabaseInsert)
          SupabaseInsertControl(
            action: action as TASupabaseInsert,
            onParamsChanged: onParamsChanged,
          ),
        if (action is TASupabaseFunctionInvoke)
          SupabaseFunctionInvokeControl(
            action: action as TASupabaseFunctionInvoke,
            onParamsChanged: onParamsChanged,
          ),
      ],
    );
  }
}
