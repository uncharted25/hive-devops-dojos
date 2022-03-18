import React, { useState } from 'react';

import logo from './logo.svg';
import './App.css';


const appStyle = {
	  height: '250px',
  	display: 'flex'
};

const formStyle = {
    margin: 'auto',
    padding: '15px',
    border: '1px solid #c9c9c9',
    borderRadius: '5px',
    background: '#f5f5f5',
    width: '220px',
  	display: 'block',
    marginTop: '100px'
};

const labelStyle = {
    margin: '10px 0 5px 0',
    fontFamily: 'Arial, Helvetica, sans-serif',
    fontSize: '15px',
};

const inputStyle = {
    margin: '5px 0 10px 0',
    padding: '5px', 
    border: '1px solid #bfbfbf',
    borderRadius: '3px',
    boxSizing: 'border-box',
    width: '100%'
};

const submitStyle = {
    margin: '10px 0 0 0',
    padding: '7px 10px',
    border: '1px solid #efffff',
    borderRadius: '3px',
    background: '#3085d6',
    width: '100%', 
    fontSize: '15px',
    color: 'white',
    display: 'block'
};

const Field = React.forwardRef(({id, label, type}, ref) => {
    return (
      <div>
        <label style={labelStyle} >{label}</label>
        <input id={id} ref={ref} type={type} style={inputStyle} />
      </div>
    );
});

const Form = () => {
    const usernameRef = React.useRef();
    const passwordRef = React.useRef();
    const [resultMessage, setResultMessage] = useState("");

    const handleSubmit = e => {
        e.preventDefault();
        if (usernameRef.current.value === "palo@it.com" && passwordRef.current.value === "1qa2ws") {
          setResultMessage("Logged in!")
        } else {
          setResultMessage("Please verify your credentials.")
        }
    };
    return (
      <form style={formStyle} onSubmit={handleSubmit} >
        <img class="form-logo" src={logo} alt="Palo-IT logo"/>
        <Field id="username" ref={usernameRef} label="Username:" type="text" />
        <Field id="password" ref={passwordRef} label="Password:" type="password" />
        <div>
          <button id="submit" style={submitStyle} type="submit">Submit</button>
        </div>
        <p>{resultMessage}</p>
      </form>
    );
};
function App() {
  return (
    <div style={appStyle}>
      <Form />
    </div>
  );
}

export default App;
