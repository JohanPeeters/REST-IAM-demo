import React from "react";
import {connect} from "react-redux";
import {Link} from "react-router";

class ProductDetails extends React.Component {
  constructor(props) {
    super(props);
    this.productId = props.params.productId;
  }

  componentWillMount() {
    this.setState({product: this.props.products.filter(product => {return product._id.$oid == this.productId})[0]});
  }

  render() {
    return(
      <div className="productDetails row">
        <h1>Details for Product ID {this.productId}</h1>
        <hr/>
        <h3>Price</h3>
        <p className="lead">{this.state.product.price}</p>
        <h3>Name</h3>
        <p className="lead">{this.state.product.name}</p>
        <hr/>
        <p>
          <Link to="/">&laquo; back to list</Link>
        </p>
      </div>
    )
  }
}

const mapStateToProps = state => {
  return {
    products: state.products
  }
};

export default connect(mapStateToProps)(ProductDetails);
