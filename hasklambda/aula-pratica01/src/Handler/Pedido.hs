{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Pedido where

import Import
import Text.Cassius
import Database.Persist.Postgresql
import qualified Prelude as P

getPedidoR :: Handler Html
getPedidoR = do
    sess <- lookupSession "_CLI"
    talvezUsuario <- return $ fmap (P.read . unpack) sess :: Handler (Maybe Cliente)
    defaultLayout $ do
        addStylesheet $ StaticR css_materialize_css
        addStylesheetRemote "https://fonts.googleapis.com/icon?family=Material+Icons"
        addScript $ StaticR js_jquery_js
        addScript $ StaticR js_materialize_js
        addScript $ StaticR js_init_js
        toWidget $ $(cassiusFile "templates/estilo/estilo.cassius")
        $(whamletFile "templates/html/header.hamlet")
        $(whamletFile "templates/html/pedido.hamlet")
        $(whamletFile "templates/html/footer.hamlet")