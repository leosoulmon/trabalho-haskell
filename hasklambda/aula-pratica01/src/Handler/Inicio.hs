{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Inicio where

import Import
import Text.Cassius
-- função para chamar html
-- entrada de parametro por url(interpolador)
-- sempre para mostrar como String ou texto use #{interpolador}
-- a parte html fica dentro do whamlet

-- getHomeR :: Text -> Handler Html
-- getHomeR var = do
--     defaultLayout $ do
--         toWidget $ [cassius|
--             p
--                 color: #{var}
--         |]
--         [whamlet|
--             <p>
--               <span>ALOOO #{var}</span>
--         |]


getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        addStylesheet $ StaticR css_materialize_css
        addStylesheetRemote "https://fonts.googleapis.com/icon?family=Material+Icons"
        addScript $ StaticR js_jquery_js
        addScript $ StaticR js_materialize_js
        addScript $ StaticR js_init_js
        toWidget $ $(cassiusFile "templates/estilo/estilo.cassius")
        $(whamletFile "templates/html/header.hamlet")
        $(whamletFile "templates/html/inicio.hamlet")
        $(whamletFile "templates/html/footer.hamlet")