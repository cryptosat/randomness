import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Verifiable',
    Svg: require('@site/static/img/verifiable.svg').default,
    description: (
      <>
        Cryptosat provides a Verifiable Random Beacon. Users can directly verify that 
        randomness is originated by one of our satellites by checking the digital signature
        attached to the beacon.
      </>
    ),
  },
  {
    title: 'Easy to Use',
    Svg: require('@site/static/img/easy-to-use.svg').default,
    description: (
      <>
        Cryptosat offers a simple HTTP API, as well an a Solidty SDK that enables
        to use the random beacon in Web2.0 and Web3.0 applications alike.
      </>
    ),
  },
  {
    title: 'Secure and Unbiased',
    Svg: require('@site/static/img/secure.svg').default,
    description: (
      <>
        Our Random Beacon is generated from true entropy collected in space, where
        no physical access to our satellites is possible, preventing the strongest adversaries
        from tampering with it.
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
