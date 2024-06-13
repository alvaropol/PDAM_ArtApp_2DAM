
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

### Steps to Start the Web Part (Angular):

1. **Install Node.js and npm:**
   - Ensure you have Node.js and npm installed on your system. You can download and install them from the Node.js website.
   - To verify that they are installed correctly, run the following commands in your terminal:
     ```bash
     node --version
     npm --version
     ```

2. **Install Project Dependencies:**
   - Navigate to the root folder of your Angular project.
   - Run the following command to install all necessary dependencies:
     ```bash
     npm install
     ```

3. **Start the Angular Application:**
   - Once the dependencies are installed, you can start the development server with:
     ```bash
     ng serve
     ```
   - Open your browser and go to `http://localhost:4200` to see the application running.

### Steps to Start the API (Spring Boot):

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
  
     ```bash
     mvn spring-boot:run
     ```

### Steps to Start the Flutter Part:

1. **Install Flutter SDK:**
   - Ensure the Flutter SDK is installed on your system. Follow the instructions on the Flutter website for installation.
   - To verify proper installation, run the following command in your terminal:
     ```bash
     flutter doctor
     ```

2. **Run the Flutter Application:**
   - Navigate to the root folder of your Flutter project.
   - Run the following command to start the Flutter application:
     ```bash
     flutter run
     ```
   - Make sure you have an emulator running, or a device connected to see the application in action.


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

- #### Get Category by its number

- **Description:** Returns a specific category by its number property.
- **HTTP Method:** GET
- **Endpoint:** `/category/filter/numero/{numero}`
- **Path Parameters:** numero (Category Number)
- **Successful Response (200):** Returns the category with its associated posts.
- **Not Found Response (404):** If the category with the specified number is not found.

### With admin role

#### Create a category

- **Description:** Create a new category for publications.
- **HTTP Method:** POST
- **Endpoint:** `/admin/category/create`
- **Request Body:** CreateCategoryDTO
- **Created Succesfull Response (201):** Returns the category created.
- **Bad Request Response (400):** If the request body is bad (bad request)

#### Edit a category

- **Description:** Edit a category with his ID.
- **HTTP Method:** PUT
- **Endpoint:** `/admin/category/edit/{categoryUuid}`
- **Path Parameters:** categoryUuid (Category ID)
- **Request Body:** CreateCategoryDTO
- **Successful Response (200):** Returns the category edited.
- **Not Found Response (404):** If the category with the specified ID is not found.
- **Bad Request Response (400):** If the request body is bad (bad request)

#### Remove a category

- **Description:** Remove a category.
- **HTTP Method:** DELETE
- **Endpoint:** `/admin/category/remove/{categoryUuid}`
- **Path Parameters:** categoryUuid (Category ID)
- **No Content Response (204):** No content in the response if the request has been succesfully.
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

### With admin role

#### Get All Paginated Comments

- **Description:** Returns a paginated list of all comments.
- **HTTP Method:** GET
- **Endpoint:** `/admin/comments/paged`
- **Successful Response (200):** Returns a paginated list of comments with their respective publications.
- **Not Found Response (404):** If no comments are found.

#### Remove a comment

- **Description:** Remove a comment.
- **HTTP Method:** DELETE
- **Endpoint:** `/admin/comment/remove/{commentUuid}`
- **Path Parameters:** commentUuid (Comment ID)
- **No Content Response (204):** No content in the response if the request has been succesfully.
- **Not Found Response (404):** If the comment with the specified ID is not found.

- #### Get Comment by the username that has commented

- **Description:** Returns a specific category by its number property.
- **HTTP Method:** GET
- **Endpoint:** `/comment/filter/{username}`
- **Path Parameters:** username (User username)
- **Successful Response (200):** Returns the commment with its associated user.
- **Not Found Response (404):** If the user with the specified username is not found.
  
# Publicacion

The publication controller provides various methods to obtain information about publications.

## Endpoints

#### Get All Publications with Pagination

- **Description:** Returns a paginated list of all publications.
- **HTTP Method:** GET
- **Endpoint:** `/publications/paged`
- **Response (200):** Returns a paginated list of publications.
- **Response (404):** If no publications are found.

#### Get All Publications without Pagination

- **Description:** Returns a list of all publications without pagination.
- **HTTP Method:** GET
- **Endpoint:** `/publications`
- **Response (200):** Returns a list of publications.
- **Response (404):** If no publications are found.

#### Get Publication by UUID

- **Description:** Returns a specific publication by its UUID.
- **HTTP Method:** GET
- **Endpoint:** `/publication/{uuid}`
- **Path Parameters:** uuid (Publication UUID)
- **Response (200):** Returns the publication.
- **Response (404):** If the publication with the specified UUID is not found.

#### Get All Publications by User

- **Description:** Returns a list of all publications posted by the authenticated user.
- **HTTP Method:** GET
- **Endpoint:** `/publication/user`
- **Response (200):** Returns a list of publications.
- **Authentication:** Required

#### Create a Publication

- **Description:** Creates a new publication.
- **HTTP Method:** POST
- **Endpoint:** `/publication/create`
- **Request Body:** CreatePublicationDTO
- **Response (201):** Returns the created publication.
- **Authentication:** Required

#### Edit a Publication

- **Description:** Edits an existing publication.
- **HTTP Method:** PUT
- **Endpoint:** `/publication/edit/{publicacionUuid}`
- **Path Parameters:** publicacionUuid (Publication UUID)
- **Request Body:** CreatePublicationDTO
- **Response (200):** Returns the edited publication.
- **Response (404):** If the publication with the specified UUID is not found.
- **Authentication:** Required

#### Remove a Publication

- **Description:** Removes an existing publication.
- **HTTP Method:** DELETE
- **Endpoint:** `/publication/remove/{publicacionUuid}`
- **Path Parameters:** publicacionUuid (Publication UUID)
- **Response (204):** No content.
- **Response (404):** If the publication with the specified UUID is not found.
- - **Response (403):** If the publication does not belong with the user authenticated.
- **Authentication:** Required

### With admin role

#### Edit a Publication with admin role

- **Description:** Edits an existing publication.
- **HTTP Method:** PUT
- **Endpoint:** `/admin/publication/edit/{publicacionUuid}`
- **Path Parameters:** publicacionUuid (Publication UUID)
- **Request Body:** CreatePublicationDTO
- **Response (200):** Returns the edited publication.
- **Response (404):** If the publication with the specified UUID is not found.
- **Authentication:** Required admin role

#### Remove a Publication with admin role

- **Description:** Removes an existing publication.
- **HTTP Method:** DELETE
- **Endpoint:** `/admin/publication/remove/{publicacionUuid}`
- **Path Parameters:** publicacionUuid (Publication UUID)
- **Response (204):** No content.
- **Response (404):** If the publication with the specified UUID is not found.
- - **Response (403):** If the user do not have enough permissions to do this request (user role, not admin)
- **Authentication:** Required admin role

#### Get Publication by its category name

- **Description:** Returns the publication/publications by its category name.
- **HTTP Method:** GET
- **Endpoint:** `/category/filter/{nombreCategoria}`
- **Path Parameters:** nombreCategoria (Category name)
- **Successful Response (200):** Returns the publication or publications with its associated category.
- **Not Found Response (404):** No publications found for the given category name.

# User

## Summary

The user controller has different methods for obtaining varied information about users, as well as methods for registration and login.

#### Register User

- **Description:** Register a new user.
- **HTTP Method:** POST
- **Endpoint:** `/auth/register`
- **Request Body:** RegisterUser
- **Successful Response (201):** Returns user details along with authentication token.
- **Bad Request Response (400):** If registration was not successful.

#### Login User

- **Description:** Authenticate user login.
- **HTTP Method:** POST
- **Endpoint:** `/auth/login`
- **Request Body:** LoginUser
- **Successful Response (201):** Returns user details along with authentication token.
- **Bad Request Response (400):** If login was not successful.

#### Get User Details

- **Description:** Get details of the authenticated user.
- **HTTP Method:** GET
- **Endpoint:** `/user/detail`
- **Request Header:** Authentication token
- **Successful Response (200):** Returns user details.
- **Not Found Response (404):** If the user is not found.

#### Add to Favorites

- **Description:** Add a publication to favorites.
- **HTTP Method:** POST
- **Endpoint:** `/favorites/add/{publicationId}`
- **Path Parameters:** publicationId (Publication UUID)
- **Request Header:** Authentication token
- **Successful Response (200):** If the publication is added to favorites successfully.
- **Not Found Response (404):** If the user or publication with the specified UUID is not found.
- **Bad Request Response (400):** If the publication is already in the user's favorite list.

#### Remove from Favorites

- **Description:** Remove a publication from favorites.
- **HTTP Method:** DELETE
- **Endpoint:** `/favorites/remove/{publicationId}`
- **Path Parameters:** publicationId (Publication UUID)
- **Request Header:** Authentication token
- **Successful Response (204):** If the publication is removed from favorites successfully.
- **Not Found Response (404):** If the user or publication with the specified UUID is not found.
- **Bad Request Response (400):** If the publication is not in the user's favorite list.

### With admin role

#### Get All Paginated Users

- **Description:** Returns a paginated list of all user of the application.
- **HTTP Method:** GET
- **Endpoint:** `/admin/users/paged`
- **Successful Response (200):** Returns a paginated list of users.
- **Not Found Response (404):** If no users are found.
- **Authentication:** Required admin role

#### Get User Details by UUID

- **Description:** Get details of a user by UUID.
- **HTTP Method:** GET
- **Endpoint:** `/admin/user/{uuid}`
- **Path Parameters:** uuid (User UUID)
- **Successful Response (200):** Returns user details.
- **Not Found Response (404):** If the user with the specified UUID is not found.
- **Authentication:** Required admin role

#### Get All Users Details

- **Description:** Get details of all users.
- **HTTP Method:** GET
- **Endpoint:** `/admin/users`
- **Successful Response (200):** Returns details of all users.
- **Not Found Response (204):** If no users are found.
- **Authentication:** Required admin role

#### Create a user with admin role

- **Description:** Create a new user with the role of admin (you need be admin for do this request).
- **HTTP Method:** POST
- **Endpoint:** `/admin/create/admin`
- **Request Body:** RegisterUser
- **Successful Response (201):** User with admin has been created succesful
- **Bad Request Response (400):** User with admin was not created, bad request body.
- **Authentication:** Required admin role

#### Edit a User

- **Description:** Edits an existing user.
- **HTTP Method:** PUT
- **Endpoint:** `/admin/edit/user/{userUuid}`
- **Path Parameters:** userUuid (User ID)
- **Request Body:** EditUserDTO
- **Response (200):** Returns the edited user.
- **Response (404):** If the user with the specified UUID is not found.
- **Authentication:** Required admin role

#### Ban a User

- **Description:** Ban an existing user.
- **HTTP Method:** PUT
- **Endpoint:** `/admin/ban/user/{userUuid}`
- **Path Parameters:** userUuid (User ID)
- **Response (200):** Returns the banned user.
- **Response (404):** If the user with the specified UUID is not found.
- **Authentication:** Required admin role

#### Get User by its username

- **Description:** Returns the user/user by its category name (flexible filtering).
- **HTTP Method:** GET
- **Endpoint:** `/admin/filter/{username}`
- **Path Parameters:** username (User username)
- **Successful Response (200):** Returns the user or users with its associated username.
- **Not Found Response (404):** No users found for the given username.

# Valoracion

## Summary

The valoracion controller has different methods for obtaining varied information about user ratings on publications.

#### Get Valoracion by User and Publication

- **Description:** Obtain the rating of a publication by the user.
- **HTTP Method:** GET
- **Endpoint:** `/user/rating/{uuidPublicacion}`
- **Path Parameters:** uuidPublicacion (Publication UUID)
- **Request Header:** Authentication token
- **Successful Response (200):** Returns the rating of the publication by the user.
- **Not Found Response (404):** If no rating is found.

#### Get All Valoraciones by User

- **Description:** Obtain a list of ratings of publications by the user.
- **HTTP Method:** GET
- **Endpoint:** `/user/rating`
- **Request Header:** Authentication token
- **Successful Response (200):** Returns a list of ratings of publications by the user.
- **Not Found Response (404):** If no rating is found.

#### Rate a Publication

- **Description:** Rate a publication.
- **HTTP Method:** POST
- **Endpoint:** `/rate/add/publication/{uuidPublicacion}/{puntuacion}`
- **Path Parameters:** uuidPublicacion (Publication UUID), puntuacion (Rating)
- **Request Header:** Authentication token
- **Successful Response (201):** If the rating is added to the publication successfully.
- **Not Found Response (404):** If the publication with the specified UUID is not found.
- **Bad Request Response (400):** If the rating value is not between 0 and 5 without decimals.

#### Delete Valoracion

- **Description:** Delete a rating from a publication.
- **HTTP Method:** DELETE
- **Endpoint:** `/rate/remove/publication/{uuidPublicacion}`
- **Path Parameters:** uuidPublicacion (Publication UUID)
- **Request Header:** Authentication token
- **Successful Response (204):** If the rating is deleted from the publication successfully.
- **Not Found Response (404):** If the publication with the specified UUID is not found.

#### Get Ratings by its value of rate

- **Description:** Returns the rating/ratings by its rating value.
- **HTTP Method:** GET
- **Endpoint:** `/rating/filter/{rating}`
- **Path Parameters:** rating (Rating value)
- **Successful Response (200):** Returns the rating or rating with its associated rating value.
- **Not Found Response (404):** No rating found for the given rating value.

### With admin role

#### Get All Paginated Ratings

- **Description:** Returns a paginated list of all ratings in the application.
- **HTTP Method:** GET
- **Endpoint:** `/admin/ratings/paged`
- **Successful Response (200):** Returns a paginated list of ratings with their respective publications and with his user associated.
- **Not Found Response (404):** If no ratings are found.
