import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import loadable from "@loadable/component";
import pMinDelay from "p-min-delay";
import { Dropdown } from "react-bootstrap";
import { Button } from "react-bootstrap";
import { Modal } from "react-bootstrap";
import { useHistory } from "react-router-dom";

//Images
import theme from "./../../../images/theme.png";
import {
  GetDashboardAction,
  loadingToggleAction,
} from "../../../store/actions/UserAction";
import { GetBillingAction } from "../../../store/actions/BillingAction";
import { GetPackageAction } from "../../../store/actions/packageAction";
import {
  storeStatusAction,
  StoreCreationStatus,
} from "../../../store/actions/AuthActions";
import { connect, useDispatch } from "react-redux";

// Load the CompletionApexChart component lazily
const CompletionApexChart = loadable(() =>
  pMinDelay(import("./Dashboard/CompletionApexChart"), 1000)
);

const Home = (props) => {
  const dispatch = useDispatch();
  const user = props.getUser;

  // Fetch user data and billing information when the component mounts
  useEffect(() => {
    dispatch(loadingToggleAction(true));
    dispatch(GetDashboardAction(user));
    dispatch(GetBillingAction());
  }, []);

  useEffect(() => {
    dispatch(GetPackageAction(props.client?.packageId));
  }, []);
  const data = props.getDashboard;

  const date1 = new Date();
  let date2;

  if (!props.client.isFreePackageClient) {
    date2 = new Date(props.bill?.expires_at);
  } else {
    date2 = new Date(props.client?.freePackageEndingDate);
  }

  const expiresin = getDifferenceInDays(date1, date2);

  // Calculate the difference in days between two dates
  function getDifferenceInDays(date1, date2) {
    const diffInMs = Math.abs(date2 - date1);
    return diffInMs / (1000 * 60 * 60 * 24);
  }

  const [modalCreate, setmodalCreate] = useState(false);
  const [loader, SetLoader] = useState(false);

  let history = useHistory();

  // Activate the store status
  const StatusChange = () => {
    SetLoader(true);
    dispatch(storeStatusAction(props.storeid, true, setmodalCreate, SetLoader));
  };

  const handlerView = () => {
    history.push("/customers");
  };

  useEffect(() => {
    dispatch(StoreCreationStatus(false));
  }, []);

  return (
    <>
      <div className="row">
        <div className="col-xl-12">
          <div className="row">
            {expiresin < 3 ? (
              <div className="col-xl-12">
                <div className="card tryal-gradient">
                  <div
                    className="card-body tryal "
                    style={{ textAlign: "center" }}
                  >
                    <h2>Your subscription plan will be end soon....</h2>
                    <Link
                      className=" btn btn-rounded  fs-18 font-w500"
                      to="/change-packages"
                    >
                      <i className="fa fa-usd"></i> Subscribe
                    </Link>
                  </div>
                </div>
              </div>
            ) : (
              ""
            )}
            <div className="col-xl-6">
              <div className="row">
                <div className="col-xl-12">
                  <div className="card tryal-gradient">
                    <div className="card-body tryal row">
                      <div className="col-xl-7 col-sm-6">
                        <h2>Manage your Market Place</h2>
                        <span>
                          Edit the look and feel of your online store. Add your
                          logo, colors, and images to reflect your brand.{" "}
                        </span>
                        <div style={{ display: "flex" }}>
                          <Link
                            to="/customize-theme"
                            className="btn btn-rounded  fs-15 font-w500"
                          >
                            Customize
                          </Link>
                          {!props.activeStatus ? (
                            <Link
                              className="btn btn-rounded  fs-15 font-w500"
                              style={{ marginLeft: "8px" }}
                              onClick={() => setmodalCreate(true)}
                            >
                              Activate Store
                            </Link>
                          ) : (
                            ""
                          )}
                        </div>
                      </div>
                      <div className="col-xl-5 col-sm-6">
                        <img src={theme} alt="" className="sd-shape" />
                      </div>
                    </div>
                  </div>
                </div>
                <div className="col-xl-12">
                  <div className="card">
                    <div className="card-header border-0 pb-0">
                      <h4 className="fs-20 font-w700 mb-0">Weekly Revenue</h4>
                    </div>
                    <div className="card-body pb-0">
                      <div id="revenueMap" className="revenueMap">
                        <CompletionApexChart />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div className="col-xl-6">
              <div className="row">
                <div className="col-xl-12">
                  <div className="row">
                    <div className="col-xl-6 col-sm-6">
                      <div className="card">
                        <div className="card-body d-flex px-4 pb-0 justify-content-between">
                          <div
                            onClick={handlerView}
                            style={{ cursor: "pointer" }}
                          >
                            <h4 className="fs-18 font-w600 mb-4 text-nowrap">
                              Total Customers
                            </h4>
                            <div className="d-flex align-items-center">
                              <h2 className="fs-32 font-w700 mb-0">
                                {data.usersCount}
                              </h2>
                              <span className="d-block ms-4"></span>
                            </div>
                          </div>

                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="70"
                            height="70"
                            fill="#bd3bb1"
                            class="bi bi-people"
                            viewBox="0 0 16 16"
                          >
                            <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1h8zm-7.978-1A.261.261 0 0 1 7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002a.274.274 0 0 1-.014.002H7.022zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM6.936 9.28a5.88 5.88 0 0 0-1.23-.247A7.35 7.35 0 0 0 5 9c-4 0-5 3-5 4 0 .667.333 1 1 1h4.216A2.238 2.238 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816zM4.92 10A5.493 5.493 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275zM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0zm3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4z" />
                          </svg>
                        </div>
                      </div>
                    </div>

                    <div className="col-xl-6 col-sm-6">
                      <div className="card">
                        <div className="card-body d-flex px-4  justify-content-between">
                          <div
                            onClick={handlerView}
                            style={{ cursor: "pointer" }}
                          >
                            <h4 className="fs-18 font-w600 mb-4 text-nowrap">
                              New Customers
                            </h4>
                            <div className="d-flex align-items-center">
                              <h2 className="fs-32 font-w700 mb-0">
                                {data.usersCount}
                              </h2>
                              <span className="d-block ms-4"></span>
                            </div>
                          </div>
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="70"
                            height="70"
                            fill="#bd3bb1"
                            class="bi bi-person-plus"
                            viewBox="0 0 16 16"
                          >
                            <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z" />
                            <path
                              fill-rule="evenodd"
                              d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"
                            />
                          </svg>
                        </div>
                      </div>
                    </div>

                    <div className="col-xl-6 col-sm-6">
                      <div className="card">
                        <div className="card-body d-flex px-4  justify-content-between">
                          <div>
                            <div
                              className=""
                              onClick={handlerView}
                              style={{ cursor: "pointer" }}
                            >
                              <h2 className="fs-32 font-w700">
                                {data.nftsCount}
                              </h2>
                              <span className="fs-18 font-w600 d-block">
                                Total NFT
                              </span>
                            </div>
                          </div>
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="70"
                            height="70"
                            fill="#bd3bb1"
                            class="bi bi-images"
                            viewBox="0 0 16 16"
                          >
                            <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z" />
                            <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2zM14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1zM2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10z" />
                          </svg>
                        </div>
                      </div>
                    </div>
                    <div className="col-xl-6 col-sm-6">
                      <div className="card">
                        <div className="card-body d-flex px-4  justify-content-between">
                          <div>
                            <div
                              className=""
                              onClick={handlerView}
                              style={{ cursor: "pointer" }}
                            >
                              <h2 className="fs-32 font-w700">
                                {data.collectionsCount}
                              </h2>
                              <span className="fs-18 font-w600 d-block">
                                Total Collections
                              </span>
                            </div>
                          </div>
                          <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="70"
                            height="70"
                            fill="#bd3bb1"
                            class="bi bi-collection"
                            viewBox="0 0 16 16"
                          >
                            <path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z" />
                          </svg>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="col-xl-12">
                  <div className="card">
                    <div className="card-body text-center ai-icon  text-primary">
                      <svg
                        id="rocket-icon"
                        className="my-2"
                        viewBox="0 0 24 24"
                        width="80"
                        height="80"
                        stroke="currentColor"
                        strokeWidth="1"
                        fill="none"
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      >
                        <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                        <line x1="3" y1="6" x2="21" y2="6"></line>
                        <path d="M16 10a4 4 0 0 1-8 0"></path>
                      </svg>

                      <h4 style={{ fontWeight: "600", color: "#bd3bb1" }}>
                        {props.package?.name}
                      </h4>
                      <h6 style={{ fontWeight: "600" }}>
                        $ {props.package?.amount}
                        {props.package?.type === "yearly_subscription" ? (
                          <>/Yr</>
                        ) : (
                          <>/Mo</>
                        )}
                      </h6>

                      <h4 className="my-2">
                        You want to Upgrade your current package?
                      </h4>
                      <Link
                        className="btn my-2 btn-primary btn-lg px-4"
                        to="/change-packages"
                      >
                        <i className="fa fa-usd"></i> Upgrade Your Package
                      </Link>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <Modal className="fade" show={modalCreate}>
        <Modal.Header>
          <Modal.Title>Activate Store</Modal.Title>
          <Button
            onClick={() => setmodalCreate(false)}
            variant=""
            className="btn-close"
          ></Button>
        </Modal.Header>
        <Modal.Body>
          <div className="row">
            <div className="col-12">
              <label className="mb-1">
                <strong>Are you sure want to activate store?</strong>
              </label>
            </div>
          </div>
        </Modal.Body>
        <Modal.Footer>
          <Button onClick={() => setmodalCreate(false)} variant="danger light">
            Close
          </Button>

          {!loader ? (
            <Button variant="primary" onClick={StatusChange}>
              Confirm
            </Button>
          ) : (
            <Button variant="outline-primary" size="sm">
              <i
                className="fa fa-spinner fa-spin"
                style={{ fontSize: "24px" }}
              ></i>
            </Button>
          )}
        </Modal.Footer>
      </Modal>
    </>
  );
};
const mapStateToProps = (state) => {
  return {
    getDashboard: state.user.getDashboard,
    getUser: state.auth.selectedStore.store_domain,
    client: state.auth.auth,
    package: state.packages.currentpackage,
    bill: state.billings.billing.currentBill,
    storeid: state.auth.selectedStore.id,
    activeStatus: state.auth.selectedStore.activeStatus,
  };
};
export default connect(mapStateToProps)(Home);
