<?php

use Airavata\API\Error\AiravataSystemException;
use Airavata\Model\AppCatalog\UserResourceProfile\UserResourceProfile;

class URPUtilities
{

    public static function get_or_create_user_resource_profile()
    {
        $userResourceProfile = URPUtilities::get_user_resource_profile();
        // Check if user has UserResourceProfile by checking isNull flag
        if ($userResourceProfile->isNull)
        {
            $userResourceProfile = URPUtilities::create_user_resource_profile();
        }
        return $userResourceProfile;
    }

    public static function get_user_resource_profile()
    {
        $userId = Session::get('username');
        $gatewayId = Session::get('gateway_id');
        return Airavata::getUserResourceProfile(Session::get('authz-token'), $userId, $gatewayId);
    }

    public static function create_user_resource_profile()
    {

        $userId = Session::get('username');
        $gatewayId = Session::get('gateway_id');
        // TODO add a description to the SSH token
        $credentialStoreToken = AdminUtilities::create_ssh_token();
        $userResourceProfileData = new UserResourceProfile(array(
                "userId" => $userId,
                "gatewayID" => $gatewayId,
                "credentialStoreToken" => $credentialStoreToken
            )
        );
        Airavata::registerUserResourceProfile(Session::get('authz-token'), $userResourceProfileData);

        return Airavata::getUserResourceProfile(Session::get('authz-token'), $userId, $gatewayId);
    }

    public static function update_user_resource_profile($userResourceProfile)
    {

        $userId = Session::get('username');
        $gatewayId = Session::get('gateway_id');
        Airavata::updateUserResourceProfile(Session::get('authz-token'), $userId, $gatewayId, $userResourceProfile);
    }

    public static function get_all_ssh_pub_keys_summary_for_user()
    {

        $userId = Session::get('username');
        $gatewayId = Session::get('gateway_id');

        return Airavata::getAllSSHPubKeysSummaryForUserInGateway(Session::get('authz-token'), $gatewayId, $userId);
    }

    // Only used for testing
    public static function delete_user_resource_profile()
    {
        $userId = Session::get('username');
        $gatewayId = Session::get('gateway_id');
        Airavata::deleteUserResourceProfile(Session::get('authz-token'), $userId, $gatewayId);
    }
}

?>