package com.salesianos.triana.ArtApi.exception;

public class ThatPublicationIsntInYourFavouriteListException extends RuntimeException {

    public ThatPublicationIsntInYourFavouriteListException(){
        super("That publication isn't in your favorite list");
    }
}