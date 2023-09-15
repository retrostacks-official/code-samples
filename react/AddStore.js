import React, { useEffect, useState, useContext } from "react";
import { Link, useHistory } from "react-router-dom";
import { connect, useDispatch } from "react-redux";
import { ThemeContext } from "../../context/ThemeContext";
import swal from "sweetalert";
import successico from "../../images/swal-success.png";
import failed from "../../images/swal-error.png";

import { packageAction } from "../../store/actions/packageAction";
import {
  saveContractDataAction,
  ContarctStandard,
  saveDataForCompaile,
  StoreCreationStatus,
} from "../../store/actions/AuthActions";
import PreviewPrice from "../components/Forms/Register/Register-new/PreviewPrice";
import MetaModal from "../components/Forms/Register/Register-new/MetaModal";
// image
import logo from "../../images/wimos_logo-01.svg";
import logowhite from "../../images/wimos_logo-white.svg";
import RegisterForm from "../components/Forms/Register/Register-new/addmain";

function AddStore(props) {
  // Use the ThemeContext for background
  const { background } = useContext(ThemeContext);

  // Define state variables
  const [step, setStep] = useState(1);
  const dispatch = useDispatch();
  const history = useHistory();

  // Effect hook to dispatch StoreCreationStatus action
  useEffect(() => {
    dispatch(StoreCreationStatus(true));
  }, []);
  const [marketplaceTemplate, setMarketplaceTemplate] = useState();

  const [feePreview, setFeePreview] = useState(props.fee);
  const [isnewstore] = useState(true);
  const [contractSuccess, setcontractSuccess] = useState("");
  const [paymentSuccess, setPaymentSuccess] = useState("");
  const [storeName, setStoreName] = useState("");
  const [subDomain, setSubDomain] = useState("");
  const [owndomainName, setOwndomainName] = useState("wimos.io");
  const [domainName, setDomainName] = useState("");
  const [domains, setDomains] = useState("");
  const [countryName, setCountryName] = useState("");
  const [countryCode, setCountryCode] = useState("+91");
  const [otpData, setOtpData] = useState("");
  const [tokenId, setTokenId] = useState("");
  const [erc721, setErc721] = useState(false);
  const [erc1155, setErc1155] = useState(false);
  const [modalCreate, setmodalCreate] = useState(false);
  const [modalMteta, setmodalMteta] = useState(false);
  const [instrumodal, setInstrumodal] = useState(false);
  const [contractType, setContractType] = useState("single_store");
  const [freemint, setFreemint] = useState(false);
  const [storeVal, setStoreVal] = useState(false);
  const [domainVal, setDomainVal] = useState(false);

  // Effect hook to dispatch packageAction
  useEffect(() => {
    dispatch(packageAction());

    if (props.store.currentStep > 1 && props.store.currentStep < 12) {
      setStep(props.store.currentStep);
      if (props.store.currentStep > 3) {
        if (props.store.contractStandard === "erc721") {
          setErc721(true);
        }
        if (props.store.contractStandard === "erc1155") {
          setErc1155(true);
        }
      }
    }
  }, [props.store]);

  // More state variables
  const [erc721Data, setErc721Data] = useState({
    accessControl: "",
    upgradeability: "",
    name: "",
    symbol: "",
    baseUri: "",
    license: "",
    securityContact: "",
    Mintable: false,
    incremental: false,
    Burnable: false,
    supply: false,
    Pausable: false,
    Votes: false,
    Enumerable: false,
    Uristorage: false,
  });
  const [erc1155Data, setErc1155Data] = useState({
    accessControl: "",
    upgradeability: "",
    name: "",
    uri: "",
    license: "",
    securityContact: "",
    Mintable: false,
    Burnable: false,
    supply: false,
    Pausable: false,
  });

  const [nameleng, setNameleng] = useState(false);
  const [conerr, setConerr] = useState(false);
  const [errors, setErrors] = useState(false);
  const [usererror, setUsererror] = useState(false);
  const [errName, setErrName] = useState({ firstName: false });
  const [errMsg, setErrMsg] = useState({
    firstName: false,
    userName: false,
    emailerr: false,
    phoneerr: false,
    passerr: false,
    conpasserr: false,
    codeerr: false,
    storeerr: false,
    domainerr: false,
    contracterr: false,
    packgree: false,
    featureserr: false,
    symbolerr: false,
    nameerr: false,
    contractType: false,
  });
  const [nextbutton, setNextbutton] = useState(false);
  const [pckgeId, setPckgeId] = useState("");

  // Proceed to next step
  const nextStep = () => {
    setNextbutton(true);
    if (step === 1) {
      if (contractType === "") {
        swal("Oops", "Please select the contract type", {
          icon: failed,
          buttons: {
            cancel: "Try Again!",
          },
        });
      } else {
        setStep(step + 1);
      }
      setNextbutton(false);
    } else if (step === 2) {
      if (storeName === "" || domainName === "") {
        if (storeName === "") {
          setErrMsg({ storeerr: true });
          setStoreVal(true);
        }

        if (domainName === "") {
          if (owndomainName.includes("wimos.io")) {
            setErrMsg({ domainerr: true });
            setDomainVal(true);
          } else {
            setErrMsg({ domainerr: false });
            setDomainVal(false);
            let valu = owndomainName;
            const Data = {
              store_name: storeName,
              domain: valu,
              network: "etherium",
              type: contractType,
            };
            dispatch(
              storeAction({
                Data,
                setStep,
                step,
                isnewstore,
                contractType,
                setNextbutton,
              })
            );
          }
        }
      } else {
        setErrMsg({ storeree: false, domainerr: false });
        setDomainVal(false);
        setStoreVal(false);
        let valu = domainName + "." + owndomainName;
        const Data = {
          store_name: storeName,
          domain: valu,
          network: "etherium",
          type: contractType,
        };
        dispatch(
          storeAction({
            Data,
            setStep,
            step,
            isnewstore,
            contractType,
            setNextbutton,
          })
        );
      }
      setNextbutton(false);
    } else if (step === 3) {
      setErrMsg({ contracterr: false });
      if (contractType === "marketplace" && !marketplaceTemplate) {
        swal("Oops", "Please select a template ", {
          icon: failed,
          buttons: {
            cancel: "Try Again!",
          },
        });
      } else if (contractType === "single_store" && !erc721 && !erc1155) {
        swal("Oops", "Please select standard", {
          icon: failed,
          buttons: {
            cancel: "Try Again!",
          },
        });
      } else {
        const Data = {
          storeId: props.storeid,
          contractStandard:
            erc721 && erc1155
              ? "combinedResult"
              : erc721
              ? "erc721"
              : "erc1155",
          marketplaceTemplate,
        };
        dispatch(
          ContarctStandard(Data, setStep, step, props.store.type, isnewstore)
        );
      }
      setNextbutton(false);
    } else if (step === 4) {
      setErrMsg({ featureserr: false });
      const Data1 = {
        storeId: props.storeid,
        userId: props.userid,
        erc20: false,
        erc721: erc721,
        erc1155: erc1155,
        governor: false,
        erc721Data: {
          accessControl: "",
          upgradeability: "",
          Info: {
            securityContact: "",
            license: "",
          },
          name: erc721Data.name,
          symbol: erc721Data.symbol,
          baseUri: "",
          enumerable: erc721Data.Enumerable,
          uriStorage: true,
          burnable: erc721Data.Burnable,
          pausable: erc721Data.Pausable,
          mintable: erc721Data.Mintable,
          incremental: true,
          votes: erc721Data.Votes,
        },
        governorData: {
          name: "",
          upgradeability: "",
          Info: {
            securityContact: "",
            license: "",
          },
          delay: "",
          period: "",
          blockTime: "",
          proposalThreshold: "",
          decimals: "",

          quorumMode: "",
          quorumPercent: "",
          quorumAbsolute: "",
          votes: false,
          timelock: false,
          bravo: false,
          settings: false,
        },
        erc20Data: {
          accessControl: "",
          upgradeability: "",
          Info: {
            securityContact: "",
            license: "",
          },
          name: "",
          symbol: "",
          baseUri: "",
          enumerable: false,
          uriStorage: false,
          burnable: false,
          pausable: false,
          mintable: false,
          incremental: false,
          votes: false,
        },
        erc1155Data: {
          accessControl: "",
          upgradeability: "",
          Info: {
            securityContact: "",
            license: "",
          },
          name: erc1155Data.name,
          uri: "",
          burnable: erc1155Data.Burnable,
          pausable: erc1155Data.Pausable,
          mintable: erc1155Data.Mintable,
          supply: true,
        },
      };

      let Data = {};
      if (erc721 && !erc1155) {
        Data = {
          storeId: props.storeid,
          mintable: erc721Data.Mintable,
          burnable: erc721Data.Burnable,
          uriStorage: true,
          pausable: erc721Data.Pausable,
          votes: erc721Data.Votes,
          enumerable: erc721Data.Enumerable,
          contractStandard: erc721 ? "erc721" : "erc1155",
          isLazyMintingContract: freemint,
        };
      } else {
        Data = {
          storeId: props.storeid,
          mintable: erc1155Data.Mintable,
          burnable: erc1155Data.Burnable,
          supply: true,
          pausable: erc1155Data.Pausable,
          contractStandard: erc721 && erc1155 ? "combinedContract" : "erc1155",
          isLazyMintingContract: freemint,
        };
      }
      if (erc721 && erc721Data.Mintable === false && !freemint) {
        setErrMsg({ featureserr: true });
        swal("Oops", "Please select the Mintable feature ", {
          icon: failed,
          buttons: {
            cancel: "Try Again!",
          },
        });
      } else if (erc1155 && erc1155Data.Mintable === false && !freemint) {
        setErrMsg({ featureserr: true });
        swal("Oops", "Please select the Mintable feature ", {
          icon: failed,
          buttons: {
            cancel: "Try Again!",
          },
        });
      } else if (erc721 && erc721Data.name === "" && !freemint) {
        setErrMsg({ nameerr: true });
      } else if (erc1155 && erc1155Data.name === "" && !freemint) {
        setErrMsg({ nameerr: true });
      } else if (erc721 && erc721Data.symbol === "" && !freemint) {
        setErrMsg({ symbolerr: true });
      } else {
        setmodalCreate(true);
        dispatch(saveContractDataAction(Data));
        dispatch(saveDataForCompaile(Data1));
      }

      setNextbutton(false);
    } else {
      setStep(step + 1);
      setNextbutton(false);
    }
  };

  // Go back to prev step
  const prevStep = () => {
    setStep(step - 1);
  };

  const query = new URLSearchParams(window.location.search);

  const success = query.get("success");
  const canceled = query.get("canceled");
  if (success !== null) {
    const sessionid = query.get("session_id");
    const Data = {
      sessionId: sessionid,
    };
    apiCallHandler(Data);
  }

  useEffect(() => {
    if (success === "true") {
      setStep(8);
    }
  }, [success]);

  useEffect(() => {
    if (canceled !== null) {
      swal("Oops", "Payment Failed", {
        icon: failed,
        buttons: {
          cancel: "Try Again!",
        },
      });
      setStep(4);
    }
  }, [canceled]);

  useEffect(() => {
    if (paymentSuccess === true) {
      if (!props.isFreePeriod) {
        swal("Success!", "Payment Done Successfully", {
          icon: successico,
          buttons: {
            confirm: "Continue",
          },
          timer: 2000,
        });
      }
      contractapiHandler(props.auth.contractdata);
    } else if (paymentSuccess === false) {
      swal("Oops", "Payment Failed", {
        icon: failed,
        buttons: {
          cancel: "Try Again!",
        },
      });
      setStep(4);
    }
  }, [paymentSuccess]);

  useEffect(() => {
    if (typeof window.ethereum === "undefined") {
      console.log("Injected Web3 Wallet is not installed!");
      setmodalMteta(true);
    }
  }, []);

  return (
    <div className="authincation h-100 p-meddle">
      <div className="container ">
        <div className="row justify-content-center h-100 align-items-center">
          <div className="col-md-9">
            <div className="authincation-content">
              {/* <div className="row no-gutters "> */}
              <div className="row no-gutters ">
                {step !== 1 &&
                step !== 3 &&
                step !== 4 &&
                step !== 6 &&
                step !== 7 &&
                step !== 8 &&
                step !== 5 &&
                step !== 10 ? (
                  <div
                    className="col-1 align-items-center side-back"
                    onClick={(e) => prevStep()}
                  >
                    <h1 style={{ color: "#fff" }}>
                      <i className="fas fa-angle-double-left shake"></i>
                    </h1>
                  </div>
                ) : (
                  <div className="col-1 align-items-center " />
                )}
                <div className="col-10">
                  <div className="auth-form">
                    <div className="text-center mb-3">
                      <Link to="#">
                        {background.value === "dark" ? (
                          <img
                            src={logowhite}
                            alt=""
                            style={{ width: "25%" }}
                          />
                        ) : (
                          <img src={logo} alt="" style={{ width: "25%" }} />
                        )}
                      </Link>
                    </div>
                    <h4 className="text-center mb-4 ">Create your account</h4>

                    <RegisterForm
                      step={step}
                      nextStep={nextStep}
                      prevStep={prevStep}
                      setNameleng={setNameleng}
                      nameleng={nameleng}
                      errors={errors}
                      setErrors={setErrors}
                      setUsererror={setUsererror}
                      usererror={usererror}
                      setConerr={setConerr}
                      conerr={conerr}
                      instrumodal={instrumodal}
                      setInstrumodal={setInstrumodal}
                      storeName={storeName}
                      setStoreName={setStoreName}
                      setOwndomainName={setOwndomainName}
                      subDomain={subDomain}
                      setSubDomain={setSubDomain}
                      owndomainName={owndomainName}
                      domainName={domainName}
                      setDomainName={setDomainName}
                      countryName={countryName}
                      setCountryName={setCountryName}
                      countryCode={countryCode}
                      setCountryCode={setCountryCode}
                      tokenId={tokenId}
                      setTokenId={setTokenId}
                      errMsg={errMsg}
                      setErrMsg={setErrMsg}
                      errName={errName}
                      seterrName={setErrName}
                      setFeePreview={setFeePreview}
                      feePreview={feePreview}
                      pckgeId={pckgeId}
                      setPckgeId={setPckgeId}
                      setOtpData={setOtpData}
                      erc721={erc721}
                      setErc721={setErc721}
                      erc1155={erc1155}
                      setErc1155={setErc1155}
                      erc721Data={erc721Data}
                      setErc721Data={setErc721Data}
                      erc1155Data={erc1155Data}
                      setErc1155Data={setErc1155Data}
                      history={history}
                      contractType={contractType}
                      setContractType={setContractType}
                      isnewstore={isnewstore}
                      freemint={freemint}
                      setStoreVal={setStoreVal}
                      storeVal={storeVal}
                      setDomainVal={setDomainVal}
                      domainVal={domainVal}
                      setFreemint={setFreemint}
                      marketplaceTemplate={marketplaceTemplate}
                      setMarketplaceTemplate={setMarketplaceTemplate}
                    />

                    {props.errorMessage && (
                      <div className="">{props.errorMessage}</div>
                    )}
                    {props.successMessage && (
                      <div className="">{props.successMessage}</div>
                    )}
                  </div>

                  {props.errorMessage && (
                    <div className="">{props.errorMessage}</div>
                  )}
                  {props.successMessage && (
                    <div className="">{props.successMessage}</div>
                  )}
                </div>
                {step !== 5 && step !== 7 ? (
                  <>
                    {!nextbutton ? (
                      <div
                        className="col-1 side-next align-items-center"
                        onClick={(e) => nextStep()}
                      >
                        <h1 style={{ color: "#fff" }}>
                          <i className="fas fa-angle-double-right  shake"></i>
                        </h1>
                      </div>
                    ) : (
                      <div className="col-1 side-next align-items-center">
                        <h1 style={{ color: "#fff" }}>
                          <i className="fas fa-angle-double-right  shake"></i>
                        </h1>
                      </div>
                    )}
                  </>
                ) : (
                  <div className="col-1 align-items-center" />
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
      <PreviewPrice
        modalCreate={modalCreate}
        setmodalCreate={setmodalCreate}
        data={erc721 ? erc721Data : erc1155Data}
        fee={feePreview}
        setPaymentSuccess={setPaymentSuccess}
        isFreePeriod={props.isFreePeriod}
        isnewstore={isnewstore}
      />
      <MetaModal modalMteta={modalMteta} setmodalMteta={setmodalMteta} />;
    </div>
  );
}

const mapStateToProps = (state) => {
  return {
    fee: state?.packages?.packages?.basicFee?.amount,
    isFreePeriod: state?.packages?.packages?.basicFee?.isFreePeriod,
    errorMessage: state.auth.errorMessage,
    successMessage: state.auth.successMessage,
    showLoading: state.auth.showLoading,
    otpid: state.auth.otpId.id,
    storeid: state.auth.storeId.id,
    store: state.auth.storeId,
    userid: state.auth.otpId.id,
    auth: state.auth,
    stores: state.auth.stores,
  };
};

export default connect(mapStateToProps)(AddStore);
