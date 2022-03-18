import React, {useState} from 'react';
import {Alert, View} from 'react-native';
import Login from '../Login/Login';
import LoginSuccess from '../LoginSuccess';

const USERNAME = 'admin';
const PASSWORD = 'password';

const LoginFlow: React.FC<{}> = () => {
  const [isLoginPass, setIsLoginPass] = useState<boolean>(false);
  const [numberOfTry, setNumberOfTry] = useState<number>(0);

  const checkUsernamePassword = (data: {username: string; password: string}) =>
    data.username === USERNAME && data.password === PASSWORD;

  const onLoginPress = (data: {username: string; password: string}) => {
    if (checkUsernamePassword(data)) {
      setIsLoginPass(true);
    } else {
      setIsLoginPass(false);
      const _numberOfTry = numberOfTry + 1;
      setNumberOfTry(_numberOfTry);
      Alert.alert(
        'Username or Password incorrect',
        `Please try again ${_numberOfTry}`,
        [{text: 'OK'}],
      );
    }
  };
  return (
    <View>
      {isLoginPass ? (
        <LoginSuccess onLogoutPress={() => setIsLoginPass(false)} />
      ) : (
        <Login onLoginPress={onLoginPress} />
      )}
    </View>
  );
};
export default LoginFlow;
