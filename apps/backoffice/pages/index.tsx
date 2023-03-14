import styles from './index.module.scss';

export function Index() {
  return (
    <div className={styles.page}>
      <div>
        <div className={styles.wave}></div>
        <div className={styles.wave}></div>
        <div className={styles.wave}></div>
        <h3 className={styles.subtitle}>Nginx deploy examples</h3>
      </div>
      <div className={styles.header}>
        <div>Backoffice</div>
        <h1>Backoffice</h1>
      </div>
    </div>
  );
}

export default Index;
