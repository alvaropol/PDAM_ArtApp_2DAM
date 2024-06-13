package com.salesianos.triana.ArtApi.exception;

public class NotFoundException extends RuntimeException {
    public NotFoundException(String entity) {
        super("No matching " + entity + " or list was found with that parameter.");
    }
}