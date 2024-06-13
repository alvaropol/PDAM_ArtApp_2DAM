package com.salesianos.triana.ArtApi.exception;

public class ThatPublicationIsAlreadyInYourFavouritePublicationException extends RuntimeException {

    public ThatPublicationIsAlreadyInYourFavouritePublicationException(){
        super("That publication is already in your favourite publications");
    }
}
