package com.salesianos.triana.ArtApi.exception;

public class YouCanNotBanYourself extends RuntimeException{
    public YouCanNotBanYourself(){
        super("You cannot ban yourself");
    }
}
