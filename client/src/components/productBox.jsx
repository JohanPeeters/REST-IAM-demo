import React from "react";
import {connect} from "react-redux";
import ProductForm from "./productForm";
import ProductList from "./productList";
import {allProducts, addProduct, deleteProduct} from "../actions/products";

class ProductBox extends React.Component {
  componentWillMount() {
    this.props.init();
  }

  render() {
    const kc = this.props.kc;
    return (
      <div className="productBox row">
        <h1>
          Welcome {kc.tokenParsed.preferred_username}&nbsp;
          <button className="btn btn-success" onClick={kc.logout}>Logout</button>
        </h1>
        <h1>Best Products ever!</h1>
        <hr/>
        <ProductList products={this.props.products} onProductDelete={this.props.handleProductDelete}/>
        <ProductForm onProductSubmit={this.props.handleProductSubmit}/>
      </div>
    );
  }
}

ProductBox.defaultProps = {
  products: []
};

const mapStateToProps = state => {
  return {
    products: state.products,
    kc: state.keycloak
  }
};

const mapDispatchToProps = dispatch => {
  return {
    init: () => {
      dispatch(allProducts());
    },
    handleProductSubmit: (product) => {
      dispatch(addProduct(product));
    },
    handleProductDelete: (product) => {
      dispatch(deleteProduct(product));
    }
  }
};

export default connect(mapStateToProps, mapDispatchToProps)(ProductBox)
