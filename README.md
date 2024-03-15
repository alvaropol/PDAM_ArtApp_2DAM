
# Virtual Art Gallery Application

![Imagen de valoracion](https://www.hispangallery.com/server/Portal_0002996/img/products/cuadro-de-paisaje-de-flores-de-casals-torres-campo-de-lavandas-60x60-cm_9407494.JPG)

## Roles
- Admin -> 1 admin: (username: admin, password: admin1)
- User (artist and normal user together) -> 3 users: (username: user1, password:user1234), (username: user2, password:user1234), (username: user3, password:user1234)

# ArtApp

ArtApp is a mobile social networking platform centered around art, where users can share posts related to various forms of art such as paintings, sculptures, photographs, etc. Users can interact with these posts in various ways such as liking them, adding them to favorites, commenting on them, and managing their own posts. Additionally, users can explore different categories of art to discover new artworks and artists.

## Using ArtApp

This application consists of a backend developed in Spring Boot (API) and a frontend in an Android development environment.

### Prerequisites

- Docker installed on your system.
- IntelliJ IDEA or another Spring Boot IDE to run the backend.
- Visual Studio Code or another code editor to run the frontend.
- Android Studio (for Android Emulator) and SDK

### Steps

1. **Start Docker Containers:**

   - Open a terminal.
   - Navigate to the root of the `api` folder.
   - Run the following command to start the Docker containers without the need to pass a specific profile:

     ```bash
     docker compose up -d
     ```

2. **Run the Backend (API):**

   - Open IntelliJ IDEA or your Spring Boot IDE.
   - Open the project in the backend (API).
   - Run the project to start the API.

3. **Run the Frontend:**

   - Open Visual Studio Code or your preferred code editor.
   - Open the project in the frontend.
   - Use an Android emulator to run the project. It is recommended to use Android Studio with the SDK.

That's it! You should now be able to use the application effectively.

## Endpoints Available

# Category

#### Get All Paginated Categories

- **Description:** Returns a paginated list of all art categories.
- **HTTP Method:** GET
- **Endpoint:** `/categories/paged`
- **Successful Response (200):** Returns a paginated list of categories with their respective posts.
- **Not Found Response (404):** If no categories are found.

#### Get All Categories

- **Description:** Returns a list of all art categories.
- **HTTP Method:** GET
- **Endpoint:** `/categories`
- **Successful Response (200):** Returns a list of categories with their respective posts.
- **Not Found Response (404):** If no categories are found.

#### Get All Categories for Publication Creation Form

- **Description:** Returns a list of all art categories to be used in a publication creation form.
- **HTTP Method:** GET
- **Endpoint:** `/categories/createform`
- **Successful Response (200):** Returns a list of categories with name and number.
- **Not Found Response (404):** If no categories are found.

#### Get Category by ID

- **Description:** Returns a specific category by its ID.
- **HTTP Method:** GET
- **Endpoint:** `/category/{uuid}`
- **Path Parameters:** uuid (Category ID)
- **Successful Response (200):** Returns the category with its associated posts.
- **Not Found Response (404):** If the category with the specified ID is not found.

# Comment

#### Add Comment to a Publication

- **Description:** Allows a user to add a comment to a publication.
- **HTTP Method:** POST
- **Endpoint:** `/comment/add/publication/{publicationId}`
- **Path Parameters:** publicationId (Publication ID)
- **Successful Response (201):** Returns the added comment to the publication.
- **Not Found Response (404):** If the user or publication with the specified ID is not found.
- **Invalid Response (400):** If the comment is empty.

# Publicacion

The publication controller provides various methods to obtain information about publications.

## Endpoints

### Get All Publications with Pagination

- **Description:** Returns a paginated list of all publications.
- **HTTP Method:** GET
- **Endpoint:** `/publications/paged`
- **Response (200):** Returns a paginated list of publications.
- **Response (404):** If no publications are found.

### Get All Publications without Pagination

- **Description:** Returns a list of all publications without pagination.
- **HTTP Method:** GET
- **Endpoint:** `/publications`
- **Response (200):** Returns a list of publications.
- **Response (404):** If no publications are found.

### Get Publication by UUID

- **Description:** Returns a specific publication by its UUID.
- **HTTP Method:** GET
- **Endpoint:** `/publication/{uuid}`
- **Path Parameters:** uuid (Publication UUID)
- **Response (200):** Returns the publication.
- **Response (404):** If the publication with the specified UUID is not found.

### Get All Publications by User

- **Description:** Returns a list of all publications posted by the authenticated user.
- **HTTP Method:** GET
- **Endpoint:** `/publication/user`
- **Response (200):** Returns a list of publications.
- **Authentication:** Required

### Create a Publication

- **Description:** Creates a new publication.
- **HTTP Method:** POST
- **Endpoint:** `/publication/create`
- **Request Body:** CreatePublicationDTO
- **Response (201):** Returns the created publication.
- **Authentication:** Required

### Edit a Publication

- **Description:** Edits an existing publication.
- **HTTP Method:** PUT
- **Endpoint:** `/publication/edit/{publicacionUuid}`
- **Path Parameters:** publicacionUuid (Publication UUID)
- **Request Body:** CreatePublicationDTO
- **Response (200):** Returns the edited publication.
- **Response (404):** If the publication with the specified UUID is not found.
- **Authentication:** Required

### Remove a Publication

- **Description:** Removes an existing publication.
- **HTTP Method:** DELETE
- **Endpoint:** `/publication/remove/{publicacionUuid}`
- **Path Parameters:** publicacionUuid (Publication UUID)
- **Response (204):** No content.
- **Response (404):** If the publication with the specified UUID is not found.
- **Authentication:** Required

# User

## Summary

The user controller has different methods for obtaining varied information about users, as well as methods for registration and login.

### Register User

- **Description:** Register a new user.
- **HTTP Method:** POST
- **Endpoint:** `/auth/register`
- **Request Body:** RegisterUser
- **Successful Response (201):** Returns user details along with authentication token.
- **Bad Request Response (400):** If registration was not successful.

### Login User

- **Description:** Authenticate user login.
- **HTTP Method:** POST
- **Endpoint:** `/auth/login`
- **Request Body:** LoginUser
- **Successful Response (201):** Returns user details along with authentication token.
- **Bad Request Response (400):** If login was not successful.

### Get User Details

- **Description:** Get details of the authenticated user.
- **HTTP Method:** GET
- **Endpoint:** `/user/detail`
- **Request Header:** Authentication token
- **Successful Response (200):** Returns user details.
- **Not Found Response (404):** If the user is not found.

### Get User Details by UUID

- **Description:** Get details of a user by UUID.
- **HTTP Method:** GET
- **Endpoint:** `/admin/user/{uuid}`
- **Path Parameters:** uuid (User UUID)
- **Successful Response (200):** Returns user details.
- **Not Found Response (404):** If the user with the specified UUID is not found.

### Get All Users Details

- **Description:** Get details of all users.
- **HTTP Method:** GET
- **Endpoint:** `/admin/users`
- **Successful Response (200):** Returns details of all users.
- **Not Found Response (204):** If no users are found.

### Add to Favorites

- **Description:** Add a publication to favorites.
- **HTTP Method:** POST
- **Endpoint:** `/favorites/add/{publicationId}`
- **Path Parameters:** publicationId (Publication UUID)
- **Request Header:** Authentication token
- **Successful Response (200):** If the publication is added to favorites successfully.
- **Not Found Response (404):** If the user or publication with the specified UUID is not found.
- **Bad Request Response (400):** If the publication is already in the user's favorite list.

### Remove from Favorites

- **Description:** Remove a publication from favorites.
- **HTTP Method:** DELETE
- **Endpoint:** `/favorites/remove/{publicationId}`
- **Path Parameters:** publicationId (Publication UUID)
- **Request Header:** Authentication token
- **Successful Response (204):** If the publication is removed from favorites successfully.
- **Not Found Response (404):** If the user or publication with the specified UUID is not found.
- **Bad Request Response (400):** If the publication is not in the user's favorite list.

# Valoracion

## Summary

The valoracion controller has different methods for obtaining varied information about user ratings on publications.

### Get Valoracion by User and Publication

- **Description:** Obtain the rating of a publication by the user.
- **HTTP Method:** GET
- **Endpoint:** `/user/rating/{uuidPublicacion}`
- **Path Parameters:** uuidPublicacion (Publication UUID)
- **Request Header:** Authentication token
- **Successful Response (200):** Returns the rating of the publication by the user.
- **Not Found Response (404):** If no rating is found.

### Get All Valoraciones by User

- **Description:** Obtain a list of ratings of publications by the user.
- **HTTP Method:** GET
- **Endpoint:** `/user/rating`
- **Request Header:** Authentication token
- **Successful Response (200):** Returns a list of ratings of publications by the user.
- **Not Found Response (404):** If no rating is found.

### Rate a Publication

- **Description:** Rate a publication.
- **HTTP Method:** POST
- **Endpoint:** `/rate/add/publication/{uuidPublicacion}/{puntuacion}`
- **Path Parameters:** uuidPublicacion (Publication UUID), puntuacion (Rating)
- **Request Header:** Authentication token
- **Successful Response (201):** If the rating is added to the publication successfully.
- **Not Found Response (404):** If the publication with the specified UUID is not found.
- **Bad Request Response (400):** If the rating value is not between 0 and 5 without decimals.

### Delete Valoracion

- **Description:** Delete a rating from a publication.
- **HTTP Method:** DELETE
- **Endpoint:** `/rate/remove/publication/{uuidPublicacion}`
- **Path Parameters:** uuidPublicacion (Publication UUID)
- **Request Header:** Authentication token
- **Successful Response (204):** If the rating is deleted from the publication successfully.
- **Not Found Response (404):** If the publication with the specified UUID is not found.