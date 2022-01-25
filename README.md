# ProjectIMT_remote

-- MODELS ---------------------

Customer -> 
Un patient a un identifiant unique, nom, prénom, date de naissance, ainsi qu'une tableau contenenant une liste de transformation. 
Il est obligatoire de fournir au moins le prénom lors de l'initialisation d'une instance de Customer.
            
Transformation -> 
Une transformation a un identifiant unique, un nom, une photo et une date d'avant et d'après transformation.
Une transformaiton peut être initialisée avec tous ses champs vides.

-------------------------------


-- VIEWMODELS -----------------

CustomerListManager ->

-------------------------------


-- VIEWS ----------------------

CameraView -> Utilise le framework AVFoundation pour créer une vue de caméra custom.
              Utilise UIKit : nécessité d'utiliser un ControllerRepresentable et un ViewCoordinator pour intégrer la vue à SwiftUI. 
              Contient un bouton pour prendre la photo, une boutton pour accepter la photo, un autre pour la reprendre.
              Si la photo est la première de la transformation, une ellipse apparait en transparence pour positionner/centrer le visage.
              Si la photo est la deuxième de la transformation, la première photo apparait en transparence pour positionner au mieux le visage.

ImagePicker -> Boutton custom permettant de selectionner/prendre une photo, et de l'afficher dans un cercle.
               Pour prendre une photo avec la caméra, on appelle CameraView().
               Sinon, on utilise UIImagePickerView() fournit par UIKit pour selectionner une photo de la galerie.

TransformationItemRow -> Présente deux ImagePicker() ainsi qu'un bouton permettant d'afficher ShowTransformationView() quand deux photos ont été prises.

ShowTransformationView -> Affiche la transformation en montrant l'évolution entre la photo "avant" et la photo "après".
                          Un slider permet de passer d'une photo à l'autre en "fondu" en modifiant linéairement la transparence des photos.

CustomerListView -> Vue principale de l'application.
                    Affiche les différents patients enregistrés, chacun possédant sa liste de transformations (les listes étant dépliables pour plus d'érgonomie).
                    Un boutton permet d'ajouter de nouveaux patients.
                    Des boutons permettent de modifier les infos des patients, de les supprimer,ou de leur ajouter de nouvelles transformations.

AddCustomerSheet ->

EditCustomerSheet ->

-------------------------------
