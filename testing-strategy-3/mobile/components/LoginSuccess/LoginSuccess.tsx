import React from 'react';
import {Button, Text, View} from 'react-native';

type PropsType = {
  onLogoutPress: () => void;
};
const LoginSuccess: React.FC<PropsType> = ({onLogoutPress}) => {
  return (
    <View>
      <Text>Success, You are already log in</Text>
      <Button testID="logout-button" onPress={onLogoutPress} title="Log out" />
    </View>
  );
};
export default LoginSuccess;
