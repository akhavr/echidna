{-# LANGUAGE DeriveGeneric, FlexibleContexts, TemplateHaskell #-}

module Echidna.Property where

import GHC.Generics
import qualified Data.HashMap.Lazy as HML        ( lookup )
import Data.Yaml

data PropertyType = ShouldReturnTrue | ShouldReturnFalse | ShouldRevert | ShouldReturnFalseRevert
  deriving (Show, Generic)

instance FromJSON PropertyType where
  parseJSON (Object o) = case HML.lookup "value" o of
        Just (String "Sucess")        -> pure ShouldReturnTrue
        Just (String "Fail")          -> pure ShouldReturnFalse
        Just (String "Throw")         -> pure ShouldRevert
        Just (String "Fail or Throw") -> pure ShouldReturnFalseRevert
        _                             -> fail "Expected return type"
  parseJSON _ = fail "Expected return type"