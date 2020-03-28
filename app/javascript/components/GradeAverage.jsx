import React from "react"
import PropTypes from "prop-types"
class GradeAverage extends React.Component {
  constructor(props) {
    super(props);
    this.state = { value: props.value, name: props.name }
  }

  render () {
    return (
      <React.Fragment>
        Value: {this.state.value}
        Name: {this.state.name}
      </React.Fragment>
    );
  }
}

GradeAverage.propTypes = {
  value: PropTypes.node,
  name: PropTypes.string
};
export default GradeAverage
