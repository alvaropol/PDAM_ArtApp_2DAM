package com.salesianos.triana.ArtApi.exception;


import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.ErrorResponse;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.net.URI;
import java.time.Instant;
import java.util.List;


@RestControllerAdvice
public class GlobalRestControllerAdvice extends ResponseEntityExceptionHandler {

    @Override
    public ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException exception,
                                                               HttpHeaders headers, HttpStatusCode status, WebRequest request) {
        List<ApiValidationSubError> validationErrors = exception.getBindingResult().getAllErrors().stream()
                .map(ApiValidationSubError::fromObjectError)
                .toList();
        ErrorResponse er = ErrorResponse.builder(exception, HttpStatus.BAD_REQUEST, exception.getMessage())
                .title("Invalid data error")
                .type(URI.create("https://artapi.com/errors/not-valid"))
                .property("Fields errors", validationErrors)
                .build();
        return ResponseEntity.status(status)
                .body(er.getBody()  );
    }

    @ExceptionHandler(LoginBanedException.class)
    public ErrorResponse handleEmailExistsException(LoginBanedException exception) {
        return ErrorResponse.builder(exception, HttpStatus.FORBIDDEN, exception.getMessage())
                .title("Login error")
                .type(URI.create("https://artapi.com/errors/user-banned"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler(ThatPublicationIsAlreadyInYourFavouritePublicationException.class)
    public ErrorResponse handleThatPublicationIsAlreadyInYourFavouritePublicationException(ThatPublicationIsAlreadyInYourFavouritePublicationException exception) {
        return ErrorResponse.builder(exception, HttpStatus.BAD_REQUEST, exception.getMessage())
                .title("Error trying add this publication in your favourite section")
                .type(URI.create("https://artapi.com/errors/publication-favorite-error"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler(NotFoundException.class)
    public ErrorResponse handleNotFoundException(NotFoundException exception) {
        return ErrorResponse.builder(exception, HttpStatus.NOT_FOUND, exception.getMessage())
                .title("Not found that in the application")
                .type(URI.create("https://artapi.com/errors/not-found"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler(ThatPublicationIsntInYourFavouriteListException.class)
    public ErrorResponse handleThatPublicationIsntInYourFavouriteListException(ThatPublicationIsntInYourFavouriteListException exception) {
        return ErrorResponse.builder(exception, HttpStatus.BAD_REQUEST, exception.getMessage())
                .title("Error trying remove that publication of your favourite list")
                .type(URI.create("https://artapi.com/errors/publication-favourite-error"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler(ThatPublicationDoesNotBelongToYourUserException.class)
    public ErrorResponse handleThatPublicationDoesNotBelongToYourUserException(ThatPublicationDoesNotBelongToYourUserException exception) {
        return ErrorResponse.builder(exception, HttpStatus.FORBIDDEN, exception.getMessage())
                .title("Error trying remove that publication")
                .type(URI.create("https://artapi.com/errors/publication-belong-error"))
                .property("timestamp", Instant.now())
                .build();
    }

    @ExceptionHandler(YouCanNotBanYourself.class)
    public ErrorResponse handleYouCanNotBanYourself(YouCanNotBanYourself exception) {
        return ErrorResponse.builder(exception, HttpStatus.FORBIDDEN, exception.getMessage())
                .title("Error trying banning this user")
                .type(URI.create("https://artapi.com/errors/ban-user-error"))
                .property("timestamp", Instant.now())
                .build();
    }
}