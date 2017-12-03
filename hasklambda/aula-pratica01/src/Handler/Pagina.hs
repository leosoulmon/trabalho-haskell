{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Pagina where

import Import
import Text.Cassius
import Database.Persist.Postgresql
import qualified Prelude as P

getHomeR :: Handler Html
getHomeR = do 
    sess <- lookupSession "_USR"
    talvezUsuario <- return $ fmap (P.read . unpack) sess :: Handler (Maybe Usuario)
    defaultLayout $ do 
        addStylesheet $ StaticR css_bootstrap_css
        toWidget $ $(cassiusFile "templates/home.cassius")
        case talvezUsuario of 
            Nothing -> $(whamletFile "templates/homeNothing.hamlet")
            Just usu -> $(whamletFile "templates/homeJust.hamlet")
