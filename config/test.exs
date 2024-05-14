use Mix.Config

config :cybersource_sdk,
  endpoint:
    "http://ics2wstest.ic3.com/commerce/1.x/transactionProcessor/CyberSourceTransaction_1.142.wsdl",
  merchant: %{
    id: "crazyegg",
    transaction_key:
      "2ct/Z4w09QCswY69OsWnziwXoU1DoIWrLg8fTSsCn1hR4z7xzokLrJMhGd/hwsgKIhL18moPj7HkzjrBgU11FBTsDlX/spH6lJNoystZqoa9/eeDYZBmMi4aueToHcmlRzSu0jVqskkIPk7lXljsMFXSl78Ia79CqhCrdLBvC1H5xN00KwZhYoLLsNz711P479I+nuNAcbPGpD/WUv36MFMwDi0VI44YDeY9EDoe0BGPtl8u2A1SrFhD2G5nWyCdsr5CpXE8qqJrkgpYX6XkcCNwqcv7NPNWwcCaWt2YKjfFtihH490zjGwZBhsvUGh1N07rlstQhY24G/1eejEpIA==",
    currency: "USD"
  },
  debug: true
