INSERT INTO usuario (uuid, username, password, email, nombre, pais, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at, last_password_change_at) VALUES ('c62db400-22e3-4e92-94db-1447f5688f2c', 'admin', '{bcrypt}$2a$10$4zcpWiElBDO8KELG3JE37ukgcCVfrdYeDd2i.F3MEioTkHFIfcqfK', 'admin@admin.com', 'admin', 'Croacia', true, true, true, true, current_timestamp, current_timestamp);
INSERT INTO usuario (uuid, username, password, email, nombre, pais, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at, last_password_change_at) VALUES ('04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'user1', '{bcrypt}$2a$10$pWJK9KslilCl0HcW5eVKOOdRd8AHuwymd0kze.WvLXM/kQVdKNRi.', 'user1@user.com', 'User 1', 'Inglaterra', true, true, true, true, current_timestamp, current_timestamp);
INSERT INTO usuario (uuid, username, password, email, nombre, pais, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at, last_password_change_at) VALUES ('e010f144-b376-4dbb-933d-b3ec8332ed0d', 'user2', '{bcrypt}$2a$10$pWJK9KslilCl0HcW5eVKOOdRd8AHuwymd0kze.WvLXM/kQVdKNRi.', 'user2@user.com', 'User 2', 'Inglaterra', true, true, true, true, current_timestamp, current_timestamp);
INSERT INTO usuario (uuid, username, password, email, nombre, pais, account_non_expired, account_non_locked, credentials_non_expired, enabled, created_at, last_password_change_at) VALUES ('5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', 'user3', '{bcrypt}$2a$10$pWJK9KslilCl0HcW5eVKOOdRd8AHuwymd0kze.WvLXM/kQVdKNRi.', 'user3@user.com', 'User 3', 'Inglaterra', true, true, true, true, current_timestamp, current_timestamp);

INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('50a6fcbd-1ef5-40ee-857d-183b15930e90',1, 'Arte Clasico', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Eustache_Le_Sueur_002.jpg/1200px-Eustache_Le_Sueur_002.jpg');
INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('0a1bb9cf-43cf-45ee-9759-ce8dcf4539d4',2, 'Arte Contemporaneo', 'https://zorrozua.es/wp-content/themes/yootheme/cache/ed/Servicios-de-consultoria-cultural-eda6ddec.webp');
INSERT INTO categoria (uuid, numero,nombre, image) VALUES ('0745c94c-1004-49d8-ac69-e226df922df0',3, 'Arte Moderno', 'https://www.shutterstock.com/image-illustration/abstract-artistic-background-golden-brushstrokes-600nw-2329423657.jpg');
INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('9d37c31a-af09-4b11-bdf1-31e8d34c5a2e', 4, 'Arte Renacentista', 'https://humanidades.com/wp-content/uploads/2018/07/arte-renacentista-e1571802362634.jpg');
INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('c04ed727-5450-4e13-bbc4-90bbd282cd9b', 5, 'Arte Barroco', 'https://humanidades.com/wp-content/uploads/2017/08/baroque-church-collegiate-church-church-melk-51381-min-e1501785740189.jpeg');
INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('9e3e91a0-91c8-426e-b3d1-3b370ca3e3bf', 6, 'Arte Romantico', 'https://www.capitaldelarte.com/wp-content/uploads/2018/02/romanticismo-capital-del-arte.jpg');
INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('4df7cfe7-3e2c-4fe1-9c53-96a1596ff292', 7, 'Arte Impresionista', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Monet_-_Impression%2C_Sunrise.jpg/1200px-Monet_-_Impression%2C_Sunrise.jpg');
INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('a4f61795-981e-4995-aac9-8eb11aef9b3e', 8, 'Arte Cubista', 'https://www.artlex.com/wp-content/uploads/2022/07/Weeping-Woman-Pablo-Picasso-1937-oil-on-canvas-Tate-Modern-London-841x1024.jpeg');
INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('f0fe9fa5-f635-4b2c-87b2-d3bfefc54739', 9, 'Arte Abstracto', 'https://artsandyou.net/cdn/shop/articles/el-arte-abstracto-lo-puede-hacer-cualquiera-467550.jpg?v=1701795623');
INSERT INTO categoria (uuid, numero, nombre, image) VALUES ('71272aae-2ba3-4c9a-b9cf-c0eef6a27644', 10, 'Arte Surrealista', 'https://media.admagazine.com/photos/6194953f238e1b959d31a78e/4:3/w_2572,h_1929,c_limit/76244.jpg');

INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('eaaa0912-a7f8-49e6-bb1d-46317237c664', 'Las Meninas', 'Una de las obras maestras de Diego Velázquez', '3x2 metros','Calle de Ruiz de Alarcón, 23, 28014 Madrid','Museo Del Prado', '40.413924', '-3.692187', 3, 'https://images.ecestaticos.com/DbBDz7lBs68b__BY2pwQONQzDP8=/178x2:1024x596/1200x675/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fe16%2Ff63%2F056%2Fe16f6305617924e00886bed07e1273f1.jpg', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', '50a6fcbd-1ef5-40ee-857d-183b15930e90');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('c5efc840-1c64-4295-ad39-ec96636e6763', 'Guernica', 'Obra de Pablo Picasso que representa el bombardeo de Guernica', '3.5x7.8 metros', 'Calle de Santa Isabel, 52, 28012 Madrid','Museo Nacional Centro de Arte Reina Sofía','40.408886', '-3.694365', 3, 'https://static5.museoreinasofia.es/sites/default/files/obras/DE00050.jpg', 'e010f144-b376-4dbb-933d-b3ec8332ed0d', '0a1bb9cf-43cf-45ee-9759-ce8dcf4539d4');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('bd7bebfc-b7dc-49cd-8055-720eca412c9c', 'La Persistencia de la Memoria', 'Conocido como "Los relojes blandos" de Salvador Dalí', '24x33 cm','Abandoibarra Etorb., 2, 48009 Bilbao, Bizkaia','Museo Guggenheim Bilbao', '43.268409', '-2.934054', 5, 'https://media.gq.com.mx/photos/5eb98f9a51cd5e1b340e8d48/master/pass/la-persistencia-de-la-memoria-de-salvador-dali-significado-foto.jpg', '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', '0745c94c-1004-49d8-ac69-e226df922df0');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a', 'La Ultima Cena', 'Famosa pintura mural de Leonardo da Vinci', '4.6x8.8 metros', 'Piazza Santa Maria delle Grazie, 2, 20123 Milano MI, Italia', 'Santa Maria delle Grazie', '45.464211', '9.191383', 5, 'https://i0.wp.com/plumasatomicas.com/wp-content/uploads/2020/04/Ultima-Cena-Jueves-Santo-Cuadro-Da-Vinci.jpg?fit=1200%2C800&ssl=1', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', '50a6fcbd-1ef5-40ee-857d-183b15930e90');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('0f8ee713-315d-4910-8452-23591e5c79df', 'La Noche Estrellada', 'Obra icónica de Vincent van Gogh', '73.7x92.1 cm', 'Museum of Modern Art, 11 W 53rd St, New York, NY 10019, Estados Unidos', 'Museum of Modern Art', '40.761433', '-73.977622', 4, 'https://c8.alamy.com/compes/2pjygtr/la-noche-estrellada-vincent-van-gogh-2pjygtr.jpg', 'e010f144-b376-4dbb-933d-b3ec8332ed0d', '0745c94c-1004-49d8-ac69-e226df922df0');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('96396a87-74bc-4c7f-b233-8e52b997af34', 'La Joven de la Perla', 'Pintura del siglo XVII de Johannes Vermeer', '44.5x39 cm', 'Mauritshuis, Korte Vijverberg 8, 2513 AB Den Haag, Países Bajos', 'Mauritshuis', '52.080933', '4.315135', 4.5, 'https://media.traveler.es/photos/613766f4d7c7024f9175e397/master/w_1600%2Cc_limit/164783.jpg', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'a4f61795-981e-4995-aac9-8eb11aef9b3e');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('7a9a2947-5d75-41d3-93ac-6d988e6ff49a', 'La Primavera', 'Famosa pintura del Renacimiento italiano de Sandro Botticelli', '203x314 cm', 'Galería de los Uffizi, Piazzale degli Uffizi, 6, 50122 Firenze FI, Italia', 'Galería de los Uffizi', '43.768490', '11.255872', 4.5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Sandro_Botticelli_-_La_Primavera_-_Google_Art_Project.jpg/1200px-Sandro_Botticelli_-_La_Primavera_-_Google_Art_Project.jpg', 'e010f144-b376-4dbb-933d-b3ec8332ed0d', '9e3e91a0-91c8-426e-b3d1-3b370ca3e3bf');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('0cfa6f35-5f92-4ff1-88c0-209b7e0a54c7', 'Nacimiento de Venus', 'Famosa obra de Sandro Botticelli que representa a la diosa Venus', '172.5x278.5 cm', 'Galería de los Uffizi, Piazzale degli Uffizi, 6, 50122 Firenze FI, Italia', 'Galería de los Uffizi', '43.768490', '11.255872', 4.5, 'https://3.bp.blogspot.com/-QOK5AfJ6lXs/Vc2dL_t5N3I/AAAAAAAAH9s/bc6rtSl6Yzo/w1200-h630-p-k-no-nu/Nacimiento%2Bde%2BVenus.jpg', '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', '9e3e91a0-91c8-426e-b3d1-3b370ca3e3bf');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('e2ed078d-4d91-4f53-b86f-71b923d6f0b2', 'La Gioconda', 'Conocida como la Mona Lisa, obra maestra de Leonardo da Vinci', '77x53 cm', 'Musée du Louvre, Rue de Rivoli, 75001 Paris, Francia', 'Musée du Louvre', '48.860611', '2.337644', 4, 'https://images.theconversation.com/files/430032/original/file-20211103-23-1lapvgt.jpeg?ixlib=rb-1.1.0&rect=19%2C1378%2C6412%2C3201&q=45&auto=format&w=1356&h=668&fit=crop', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', '0745c94c-1004-49d8-ac69-e226df922df0');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('e127f15a-d642-4b84-8a63-d96290f83e4c', 'La Fuente', 'Famosa escultura de Marcel Duchamp, a veces considerada como la obra de arte más influyente del siglo XX', '128.3x48.3x35.5 cm', 'Philadelphia Museum of Art, 2600 Benjamin Franklin Pkwy, Philadelphia, PA 19130, Estados Unidos', 'Philadelphia Museum of Art', '39.965501', '-75.180164', 5, 'https://historia-arte.com/_/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpbSI6WyJcL2FydHdvcmtcL2ltYWdlRmlsZVwvbGEtZnVlbnRlLWR1Y2hhbXAuanBnIiwicmVzaXplLDIwMDAsMjAwMCJdfQ.tGSvnG4V-wz2AgEv1tW68xXVyQ38aYHMIDPRrgo-VaU.jpg', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'a4f61795-981e-4995-aac9-8eb11aef9b3e');
INSERT INTO publicacion (uuid, titulo, descripcion, tamanyo_dimensiones, direccion_obra, nombre_museo, lat, lon, valoracion_media, image, usuario_id, categoria_id) VALUES ('b9eb8f28-d9ff-494e-88a4-af82cd7924a3', 'El Pensador', 'Famosa escultura de Auguste Rodin que representa a un hombre en profunda meditación', '181.5 cm', 'Musée Rodin, 77 Rue de Varenne, 75007 Paris, Francia', 'Musée Rodin', '48.855692', '2.315068', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/El_pensador-Rodin-Caixaforum-2.jpg/800px-El_pensador-Rodin-Caixaforum-2.jpg', '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', 'a4f61795-981e-4995-aac9-8eb11aef9b3e');


INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('7e63d4d2-b8dd-475e-8b8b-0f7d117a4e6c', '¡Una obra increible!', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'eaaa0912-a7f8-49e6-bb1d-46317237c664');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('c0c84917-4acd-422b-bdcb-190f4fc8948e', 'Me encanta el simbolismo en esta pintura', 'e010f144-b376-4dbb-933d-b3ec8332ed0d', 'c5efc840-1c64-4295-ad39-ec96636e6763');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('0737b7b4-7832-42f0-9690-f701635c7f41', 'Una obra surrealista impresionante', '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', 'bd7bebfc-b7dc-49cd-8055-720eca412c9c');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('af3ac4d7-7d2e-4b3b-bb92-44ab53e0a81c', '¡Una obra maestra!', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('f6de6b2e-1635-4b4c-98b1-ecb2d841700f', '¡Increíble detalle en cada pincelada!', 'e010f144-b376-4dbb-933d-b3ec8332ed0d', '0f8ee713-315d-4910-8452-23591e5c79df');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('7349e0da-21b0-498b-80b1-6e3e24481e02', 'Una obra surrealista impresionante', '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', '0f8ee713-315d-4910-8452-23591e5c79df');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('85db418f-1508-45ac-9a16-5e127d55c0c5', '¡Una obra maestra!', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', '96396a87-74bc-4c7f-b233-8e52b997af34');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('f87428ad-ba6b-45ee-a80e-efad53d303f0', 'Me encanta la delicadeza en cada detalle', 'e010f144-b376-4dbb-933d-b3ec8332ed0d', '7a9a2947-5d75-41d3-93ac-6d988e6ff49a');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('b29293c5-fde3-4d99-9ae7-431ed36428df', '¡Una pieza de arte unica!', '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', '0cfa6f35-5f92-4ff1-88c0-209b7e0a54c7');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('c7993f91-4fa0-4980-bd96-67a74f374617', 'Inspirador', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'e2ed078d-4d91-4f53-b86f-71b923d6f0b2');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('c6edaa13-664f-49a0-afee-898d43c608a9', 'Que belleza de obra', '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', 'eaaa0912-a7f8-49e6-bb1d-46317237c664');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('ea9adba2-2801-49ed-a509-590a406e9dc0', 'No hay mejor obra que esta', '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', 'eaaa0912-a7f8-49e6-bb1d-46317237c664');
INSERT INTO comentario (uuid, comment, usuario_id, publicacion_id) VALUES ('f34bba63-ca08-44dd-97fd-14aa0babe69e', 'Incredible on the night', '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'eaaa0912-a7f8-49e6-bb1d-46317237c664');

INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (4, '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'eaaa0912-a7f8-49e6-bb1d-46317237c664');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (1, 'c62db400-22e3-4e92-94db-1447f5688f2c', 'eaaa0912-a7f8-49e6-bb1d-46317237c664');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (3, 'e010f144-b376-4dbb-933d-b3ec8332ed0d', 'c5efc840-1c64-4295-ad39-ec96636e6763');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (5, '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', 'bd7bebfc-b7dc-49cd-8055-720eca412c9c');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (5, '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'fdb4326b-0b5e-4f1d-8b47-5eb7e60d1d4a');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (4, 'e010f144-b376-4dbb-933d-b3ec8332ed0d', '0f8ee713-315d-4910-8452-23591e5c79df');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (4, '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', '96396a87-74bc-4c7f-b233-8e52b997af34');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (5, 'e010f144-b376-4dbb-933d-b3ec8332ed0d', '7a9a2947-5d75-41d3-93ac-6d988e6ff49a');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (4, '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', '0cfa6f35-5f92-4ff1-88c0-209b7e0a54c7');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (5, '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'e2ed078d-4d91-4f53-b86f-71b923d6f0b2');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (3, 'e010f144-b376-4dbb-933d-b3ec8332ed0d', 'b9eb8f28-d9ff-494e-88a4-af82cd7924a3');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (5, '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'e127f15a-d642-4b84-8a63-d96290f83e4c');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (5, '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', '96396a87-74bc-4c7f-b233-8e52b997af34');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (4, '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', '7a9a2947-5d75-41d3-93ac-6d988e6ff49a');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (5, 'e010f144-b376-4dbb-933d-b3ec8332ed0d', '0cfa6f35-5f92-4ff1-88c0-209b7e0a54c7');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (3, '5cf8b808-3b6e-4d9d-90d5-65c83b0e75b2', 'e2ed078d-4d91-4f53-b86f-71b923d6f0b2');
INSERT INTO valoracion (puntuacion, usuario_id, publicacion_id) VALUES (5, '04d0595e-45d5-4f63-8b53-1d79e9d84a5d', 'b9eb8f28-d9ff-494e-88a4-af82cd7924a3');
