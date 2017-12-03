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
        --addStylesheet $ StaticR css_materialize_css
        addStylesheetRemote "https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css"
        addStylesheetRemote "https://fonts.googleapis.com/icon?family=Material+Icons"
        addScriptRemote "https://code.jquery.com/jquery-3.2.1.min.js"
        addScriptRemote "https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"
        --addScript $ StaticR js_jquery_js
        --addScript $ StaticR js_materialize_js
        toWidget $ $(cassiusFile "templates/estilo/estilo.cassius")
        toWidget $ [hamlet|
            $newline never
            $doctype 5
            <html>
                <head>
                    <title>
                        ola
                <body>
                    <p>
                        oi
        |]
        
        
