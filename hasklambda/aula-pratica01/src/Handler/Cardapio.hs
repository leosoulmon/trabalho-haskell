{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Cardapio where

import Import
import Text.Cassius
import Database.Persist.Postgresql
import qualified Prelude as P

getCardapioR :: Handler Html
getCardapioR = do
    sess <- lookupSession "_CLI"
    talvezUsuario <- return $ fmap (P.read . unpack) sess :: HandlerT App IO (Maybe Cliente)
    defaultLayout $ do
        addStylesheet $ StaticR css_materialize_css
        addStylesheetRemote "https://fonts.googleapis.com/icon?family=Material+Icons"
        addScript $ StaticR js_jquery_js
        addScript $ StaticR js_materialize_js
        addScript $ StaticR js_init_js
        toWidget $ $(cassiusFile "templates/estilo/estilo.cassius")
        $(whamletFile "templates/html/header.hamlet")
        $(whamletFile "templates/html/cardapio.hamlet")
        $(whamletFile "templates/html/footer.hamlet")