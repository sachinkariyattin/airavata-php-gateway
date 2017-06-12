<?php

use Airavata\Model\User\Status;
use Airavata\Model\User\UserProfile;

class UserProfileUtilities
{

    public static function does_user_profile_exist($userId) {
        $gatewayId = Session::get('gateway_id');
        return Airavata::doesUserProfileExist(Session::get('authz-token'), $userId, $gatewayId);
    }

    public static function create_basic_user_profile($username, $userEmail) {
        $gatewayId = Session::get("gateway_id");
        $userProfileData = array();
        $userProfileData["airavataInternalUserId"] = $username . '@' . $gatewayId;
        $userProfileData["userId"] = $username;
        $userProfileData["gatewayId"] = $gatewayId;
        $userProfileData["emails"] = array($userEmail);

        Log::info("creating basic user profile for user", array($userProfileData));
        return UserProfileUtilities::add_user_profile($userProfileData);
    }

    public static function add_user_profile($userProfileData) {

        $userProfile = new UserProfile($userProfileData);
        $userProfile->creationTime = time();
        $userProfile->lastAccessTime = time();
        $userProfile->validUntil = -1;
        $userProfile->State = Status::ACTIVE;
        return Airavata::addUserProfile(Session::get('authz-token'), $userProfile);
    }

    public static function get_user_profile($userId) {

        $gatewayId = Session::get('gateway_id');
        return Airavata::getUserProfileById(Session::get('authz-token'), $userId, $gatewayId);
    }

    public static function update_user_profile($userProfile) {

        return Airavata::updateUserProfile(Session::get('authz-token'), $userProfile);
    }
}

?>