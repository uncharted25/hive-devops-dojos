import React, {useState} from 'react';
import {Button, Text, TextInput, View} from 'react-native';

type PropsType = {
  onLoginPress: (data: {username: string; password: string}) => void;
};
const Login: React.FC<PropsType> = ({onLoginPress}) => {
  const [username, setUsername] = useState<string>('');
  const [password, setPassword] = useState<string>('');
  const onPress = () => {
    onLoginPress({username, password});
  };
  return (
    <View>
      <Text>Login Page</Text>
      <TextInput
        testID="username-input"
        placeholder="Username"
        onChangeText={text => setUsername(text)}
      />
      <TextInput
        testID="password-input"
        placeholder="Password"
        secureTextEntry={true}
        onChangeText={text => setPassword(text)}
      />
      <Button
        testID="login-button"
        onPress={onPress}
        title="Login"
        accessibilityLabel="Learn more about this purple button"
      />
    </View>
  );
};
export default Login;
