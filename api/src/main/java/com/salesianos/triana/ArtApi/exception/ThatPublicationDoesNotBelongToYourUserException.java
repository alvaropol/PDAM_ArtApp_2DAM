package com.salesianos.triana.ArtApi.exception;

public class ThatPublicationDoesNotBelongToYourUserException extends RuntimeException {
    public ThatPublicationDoesNotBelongToYourUserException(){
        super("The publication does not belong to your user");
    }
}
