package com.salesianos.triana.ArtApi.exception;

public class LoginBanedException extends RuntimeException {

    public LoginBanedException(){
        super("You are banned in the application");
    }
}
